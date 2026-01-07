import 'dart:convert';
import 'package:flutter/material.dart';
import 'shop.pb.dart';
import '../../../constants/category_colors.dart';

class TimeInterval {
  final String open;
  final String close;

  TimeInterval({required this.open, required this.close});

  factory TimeInterval.fromJson(Map<String, dynamic> json) {
    return TimeInterval(
      open: json['open'] as String,
      close: json['close'] as String,
    );
  }

  /// Check if a given time is within this interval on a specific date
  bool contains(DateTime now) {
    final start = _parseTime(open, now);
    var end = _parseTime(close, now);

    // If end is before or same as start, it might mean next day (e.g. 17:00 - 02:00)
    // But crawler stores 02:00 as 26:00? Let's check _parseTime logic.
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }

    return (now.isAtSameMomentAs(start) || now.isAfter(start)) &&
        now.isBefore(end);
  }

  DateTime _parseTime(String timeStr, DateTime referenceDay) {
    final parts = timeStr.split(':');
    var hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    // Handle 24+ hours (e.g. 26:00)
    var daysToAdd = 0;
    if (hour >= 24) {
      daysToAdd = hour ~/ 24;
      hour = hour % 24;
    }

    return DateTime(
      referenceDay.year,
      referenceDay.month,
      referenceDay.day,
      hour,
      minute,
    ).add(Duration(days: daysToAdd));
  }
}

class ParsedOpeningHours {
  final Map<String, List<TimeInterval>> days;

  ParsedOpeningHours(this.days);

  factory ParsedOpeningHours.fromJsonString(String jsonStr) {
    if (jsonStr.isEmpty) return ParsedOpeningHours({});
    try {
      final Map<String, dynamic> decoded = json.decode(jsonStr);
      final Map<String, List<TimeInterval>> days = {};
      decoded.forEach((key, value) {
        if (value is List) {
          days[key] = value
              .map((i) => TimeInterval.fromJson(i as Map<String, dynamic>))
              .toList();
        }
      });
      return ParsedOpeningHours(days);
    } catch (_) {
      return ParsedOpeningHours({});
    }
  }

  bool isOpenAt(DateTime now) {
    if (days.isEmpty) return true; // Default to open if no data

    final dayKeys = _getDayKeys(now);

    // Check today's intervals
    for (final dayKey in dayKeys) {
      final intervals = days[dayKey];
      if (intervals != null) {
        for (final interval in intervals) {
          if (interval.contains(now)) return true;
        }
      }
    }

    // Also check "yesterday's" intervals that might overflow into today
    final yesterday = now.subtract(const Duration(days: 1));
    final yesterdayKeys = _getDayKeys(yesterday);
    for (final dayKey in yesterdayKeys) {
      final intervals = days[dayKey];
      if (intervals != null) {
        for (final interval in intervals) {
          // We check if yesterday's interval (with +1 day logic) contains 'now'
          // interval.contains(now) uses referenceDay = now.
          // We need referenceDay = yesterday.
          if (_intervalContainsOnDay(interval, now, yesterday)) return true;
        }
      }
    }

    return false;
  }

  bool _intervalContainsOnDay(
    TimeInterval interval,
    DateTime now,
    DateTime day,
  ) {
    final start = interval._parseTime(interval.open, day);
    var end = interval._parseTime(interval.close, day);
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }
    return (now.isAtSameMomentAs(start) || now.isAfter(start)) &&
        now.isBefore(end);
  }

  List<String> _getDayKeys(DateTime dt) {
    final List<String> keys = [];
    final weekday = dt.weekday; // 1 = Mon, 7 = Sun
    keys.add(['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'][weekday - 1]);

    // Always include 'hol' check (simplification: we don't know if it's a holiday yet)
    // But if 'hol' is present, it might be applied.
    // In reality, we need a holiday checker. For now, we prioritze day of week.
    return keys;
  }

  String getTodaysHours(DateTime now) {
    final dayKey = [
      'mon',
      'tue',
      'wed',
      'thu',
      'fri',
      'sat',
      'sun',
    ][now.weekday - 1];
    final intervals = days[dayKey];
    if (intervals == null || intervals.isEmpty) return '';
    return intervals.map((i) => '${i.open} - ${i.close}').join(', ');
  }
}

extension ShopExtension on Shop {
  /// Get the actual food category, handling both enum and string fallback
  FoodCategory get effectiveFoodCategory {
    if (foodCategory != FoodCategory.FOOD_CATEGORY_UNSPECIFIED) {
      return foodCategory;
    }
    // Fallback: try to map the string 'category' to enum
    if (category.isEmpty) return FoodCategory.FOOD_CATEGORY_UNSPECIFIED;

    final upper = category.toUpperCase();
    return FoodCategory.values.firstWhere(
      (e) => e.name == upper,
      orElse: () => FoodCategory.FOOD_CATEGORY_UNSPECIFIED,
    );
  }

  /// Get color for this shop based on category
  Color get color => ShopCategory.getColor(effectiveFoodCategory);

  /// Get marker size based on whether this is a chain
  double get markerSize => ShopStyle.getMarkerSize(isChain);

  /// Opening hours logic
  ParsedOpeningHours get parsedOpeningHours =>
      ParsedOpeningHours.fromJsonString(openingHours);

  bool get isOpen => parsedOpeningHours.isOpenAt(DateTime.now());

  String get todaysOpeningHours =>
      parsedOpeningHours.getTodaysHours(DateTime.now());
}
