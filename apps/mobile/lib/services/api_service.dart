import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shop.dart' as model;
import '../api/fof/v1/fof.pb.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late String _baseUrl;

  void init({String host = 'localhost', int port = 8080}) {
    _baseUrl = 'http://$host:$port';
  }

  Future<model.UpdateLocationResponse> updateLocation(List<LatLng> path) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/location'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'path': path.map((l) => {'lat': l.lat, 'lng': l.lng}).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return model.UpdateLocationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update location: ${response.statusCode}');
    }
  }

  Future<model.GetNearbyShopsResponse> getNearbyShops(
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
      return model.GetNearbyShopsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get nearby shops: ${response.statusCode}');
    }
  }

  Future<model.GetVisitedShopsResponse> getVisitedShops() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/shops/visited'),
    );

    if (response.statusCode == 200) {
      return model.GetVisitedShopsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get visited shops: ${response.statusCode}');
    }
  }

  Future<model.GetClearedAreaResponse> getClearedArea() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/location/cleared'),
    );

    if (response.statusCode == 200) {
      return model.GetClearedAreaResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get cleared area: ${response.statusCode}');
    }
  }

  Future<model.GetNearbyShopsResponse> getQuestShop(String category) async {
    final uri = Uri.parse('$_baseUrl/v1/shops/quest').replace(
      queryParameters: {'category': category},
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return model.GetNearbyShopsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get quest shop: ${response.statusCode}');
    }
  }

  Future<model.CreateVisitResponse> createVisit(String shopId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/visits'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'shopId': shopId,
      }),
    );

    if (response.statusCode == 200) {
      return model.CreateVisitResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create visit: ${response.statusCode}');
    }
  }
}
