import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/fof/v1/fof.pb.dart';
import '../api/fof/v1/shop_extensions.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late String _baseUrl;

  void init({String host = 'localhost', int port = 8080}) {
    // _baseUrl = 'http://$host:$port';
    _baseUrl = 'https://333a3bb6e497.ngrok-free.app';
  }

  Future<UpdateLocationResponse> updateLocation(List<LatLng> path) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/location'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'path': path.map((l) => {'lat': l.lat, 'lng': l.lng}).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return UpdateLocationResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update location: ${response.statusCode}');
    }
  }

  Future<GetNearbyShopsResponse> getNearbyShops(
      double lat, double lng, double radius) async {
    final uri = Uri.parse('$_baseUrl/v1/shops/nearby').replace(
      queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'radiusMeters': radius.toString(),
      },
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return GetNearbyShopsResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get nearby shops: ${response.statusCode}');
    }
  }

  Future<GetVisitedShopsResponse> getVisitedShops() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/shops/visited'),
    );

    if (response.statusCode == 200) {
      return GetVisitedShopsResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get visited shops: ${response.statusCode}');
    }
  }

  Future<GetClearedAreaResponse> getClearedArea() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/location/cleared'),
    );

    if (response.statusCode == 200) {
      return GetClearedAreaResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get cleared area: ${response.statusCode}');
    }
  }

  Future<GetNearbyShopsResponse> getQuestShop(String category) async {
    final uri = Uri.parse('$_baseUrl/v1/shops/quest').replace(
      queryParameters: {'category': category},
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return GetNearbyShopsResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get quest shop: ${response.statusCode}');
    }
  }

  Future<CreateVisitResponse> createVisit(String shopId, int rating, String comment) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/visits'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'shopId': shopId,
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode == 200) {
      return CreateVisitResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create visit: ${response.statusCode}');
    }
  }

  Future<GetAchievementsResponse> getAchievements() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/achievements'),
    );

    if (response.statusCode == 200) {
      return GetAchievementsResponse()..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get achievements: ${response.statusCode}');
    }
  }
}
