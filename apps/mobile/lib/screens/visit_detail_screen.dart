import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../api/fof/v1/fof.pb.dart';
import 'package:intl/intl.dart';

class VisitDetailScreen extends StatelessWidget {
  final VisitedShop visit;

  const VisitDetailScreen({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    final shop = visit.shop;
    final visitedAt = DateTime.parse(visit.visitedAt).toLocal();
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');

    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Visit Review'),
        backgroundColor: AppTheme.lightSurface,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildShopHeader(shop),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildVisitSummary(visitedAt, dateFormat),
                   const SizedBox(height: 32),
                   _buildReviewSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopHeader(Shop shop) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightSurface,
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconForCategory(shop.category),
              color: AppTheme.primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            shop.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppTheme.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            shop.category,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (shop.address.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              shop.address,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitSummary(DateTime date, DateFormat format) {
    return Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.event_available_rounded, color: AppTheme.primaryColor, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visited on',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondaryLight),
                ),
                Text(
                  format.format(date),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR REVIEW',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppTheme.primaryColor,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < visit.rating ? Icons.star_rounded : Icons.star_outline_rounded,
              color: index < visit.rating ? Colors.amber : Colors.grey[300],
              size: 32,
            );
          }),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.format_quote_rounded, color: Colors.grey, size: 24),
              const SizedBox(height: 8),
              Text(
                visit.comment.isNotEmpty ? visit.comment : 'No comment provided.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: visit.comment.isNotEmpty 
                    ? AppTheme.textPrimaryLight 
                    : Colors.grey[400],
                  fontStyle: visit.comment.isNotEmpty ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'RESTAURANT':
        return Icons.restaurant_rounded;
      case 'CAFE':
        return Icons.coffee_rounded;
      case 'BAR':
        return Icons.local_bar_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}
