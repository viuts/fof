import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../api/fof/v1/common.pb.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/location.pb.dart';
import '../api/fof/v1/visit.pb.dart';
import '../api/fof/v1/achievement.pb.dart';
import '../api/fof/v1/user.pb.dart';
import '../api/fof/v1/ranking.pb.dart';
import '../api/fof/v1/quest.pb.dart';
import '../config/environment_config.dart';
import 'package:fixnum/fixnum.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late String _baseUrl;

  void init() {
    _baseUrl = EnvironmentConfig.apiUrl;
  }

  Future<Map<String, String>> getHeaders() => _getHeaders();

  Future<Map<String, String>> _getHeaders() async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<UpdateLocationResponse> updateLocation(List<LatLng> path) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/location'),
      headers: await _getHeaders(),
      body: jsonEncode(UpdateLocationRequest(path: path).toProto3Json()),
    );

    if (response.statusCode == 200) {
      return UpdateLocationResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update location: ${response.statusCode}');
    }
  }

  Future<GetNearbyShopsResponse> getNearbyShops(
    double lat,
    double lng,
    double radius, {
    bool exclusiveIndependent = false,
  }) async {
    final uri = Uri.parse('$_baseUrl/v1/shops/nearby').replace(
      queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'radiusMeters': radius.toString(),
        'exclusiveIndependent': exclusiveIndependent.toString(),
      },
    );
    final response = await http.get(uri, headers: await _getHeaders());

    if (response.statusCode == 200) {
      return GetNearbyShopsResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get nearby shops: ${response.statusCode}');
    }
  }

  Future<GetVisitedShopsResponse> getVisitedShops() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/shops/visited'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetVisitedShopsResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get visited shops: ${response.statusCode}');
    }
  }

  Future<GetClearedAreaResponse> getClearedArea({
    double? minLat,
    double? minLng,
    double? maxLat,
    double? maxLng,
  }) async {
    final queryParams = <String, String>{};
    if (minLat != null) queryParams['minLat'] = minLat.toString();
    if (minLng != null) queryParams['minLng'] = minLng.toString();
    if (maxLat != null) queryParams['maxLat'] = maxLat.toString();
    if (maxLng != null) queryParams['maxLng'] = maxLng.toString();

    final uri = Uri.parse(
      '$_baseUrl/v1/location/cleared',
    ).replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders());

    if (response.statusCode == 200) {
      return GetClearedAreaResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get cleared area: ${response.statusCode}');
    }
  }

  Future<GetFogStatsResponse> getFogStats() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/location/stats'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetFogStatsResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get fog stats: ${response.statusCode}');
    }
  }

  Future<StartQuestResponse> startQuest({
    required double lat,
    required double lng,
    required double radius,
    List<String> categories = const [],
    String keyword = '',
    QuestRatingFilter ratingFilter =
        QuestRatingFilter.QUEST_RATING_FILTER_UNSPECIFIED,
    int? openAtTime,
    bool exclusiveIndependent = false,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/quests/start'),
      headers: await _getHeaders(),
      body: jsonEncode(
        StartQuestRequest(
          lat: lat,
          lng: lng,
          radiusMeters: radius,
          categories: categories,
          keyword: keyword,
          ratingFilter: ratingFilter,
          openAtTime: openAtTime != null ? Int64(openAtTime) : Int64(0),
          exclusiveIndependent: exclusiveIndependent,
        ).toProto3Json(),
      ),
    );

    if (response.statusCode == 200) {
      return StartQuestResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to start quest: ${response.statusCode}');
    }
  }

  Future<CreateVisitResponse> createVisit(
    String shopId,
    int rating,
    String comment,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/visits'),
      headers: await _getHeaders(),
      body: jsonEncode(
        CreateVisitRequest(
          shopId: shopId,
          rating: rating,
          comment: comment,
        ).toProto3Json(),
      ),
    );

    if (response.statusCode == 200) {
      return CreateVisitResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create visit: ${response.statusCode}');
    }
  }

  Future<GetAchievementsResponse> getAchievements() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/achievements'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetAchievementsResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get achievements: ${response.statusCode}');
    }
  }

  Future<GetProfileResponse> getProfile() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/users/profile'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetProfileResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get profile: ${response.statusCode}');
    }
  }

  Future<UpdateProfileResponse> updateProfile({
    String? displayName,
    String? profileImage,
  }) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/v1/users/profile'),
      headers: await _getHeaders(),
      body: jsonEncode(
        UpdateProfileRequest(
          displayName: displayName,
          profileImage: profileImage,
        ).toProto3Json(),
      ),
    );

    if (response.statusCode == 200) {
      return UpdateProfileResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile: ${response.statusCode}');
    }
  }

  Future<String> uploadProfileImage(dynamic imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final storageRef = FirebaseStorage.instanceFor(
      bucket: EnvironmentConfig.storageBucket,
    ).ref();
    final imageRef = storageRef.child('profiles/${user.uid}/profile.jpg');

    if (imageFile is List<int>) {
      await imageRef.putData(Uint8List.fromList(imageFile));
    } else {
      // Assuming imageFile is File for mobile
      await imageRef.putFile(imageFile);
    }

    return await imageRef.getDownloadURL();
  }

  Future<UpdateVisitResponse> updateVisit({
    required String shopId,
    required int rating,
    required String comment,
    required List<String> imageUrls,
  }) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/v1/visits'),
      headers: await _getHeaders(),
      body: jsonEncode(
        UpdateVisitRequest(
          shopId: shopId,
          rating: rating,
          comment: comment,
          imageUrls: imageUrls,
        ).toProto3Json(),
      ),
    );

    if (response.statusCode == 200) {
      return UpdateVisitResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update visit: ${response.statusCode}');
    }
  }

  Future<String> uploadVisitImage(String shopId, dynamic imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final storageRef = FirebaseStorage.instanceFor(
      bucket: EnvironmentConfig.storageBucket,
    ).ref();

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    // Use shopId as folder name to group visit images
    final imageRef = storageRef.child('visits/${user.uid}/$shopId/$fileName');

    if (imageFile is List<int>) {
      await imageRef.putData(Uint8List.fromList(imageFile));
    } else {
      await imageRef.putFile(imageFile);
    }

    return await imageRef.getDownloadURL();
  }

  // --- Ranking API ---

  Future<GetRankingResponse> getAreaCoverageRanking({int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/rankings/area-coverage?limit=$limit'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetRankingResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to get area coverage ranking: ${response.statusCode}',
      );
    }
  }

  Future<GetRankingResponse> getLevelRanking({int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/rankings/level?limit=$limit'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetRankingResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get level ranking: ${response.statusCode}');
    }
  }

  Future<GetRankingResponse> getVisitCountRanking({int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/rankings/visit-count?limit=$limit'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetRankingResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to get visit count ranking: ${response.statusCode}',
      );
    }
  }

  Future<GetRankingResponse> getCategoryVisitRanking(
    String category, {
    int limit = 100,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/rankings/category/$category?limit=$limit'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetRankingResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to get category visit ranking: ${response.statusCode}',
      );
    }
  }

  // --- Quest Management ---

  Future<GetActiveQuestResponse> getActiveQuest() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/v1/quests/active'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return GetActiveQuestResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get active quest: ${response.statusCode}');
    }
  }

  Future<CancelQuestResponse> cancelQuest(String questId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/quests/cancel'),
      headers: await _getHeaders(),
      body: jsonEncode(CancelQuestRequest(questId: questId).toProto3Json()),
    );

    if (response.statusCode == 200) {
      return CancelQuestResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to cancel quest: ${response.statusCode}');
    }
  }

  Future<CompleteQuestResponse> completeQuest(String questId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/quests/complete'),
      headers: await _getHeaders(),
      body: jsonEncode(CompleteQuestRequest(questId: questId).toProto3Json()),
    );

    if (response.statusCode == 200) {
      return CompleteQuestResponse()
        ..mergeFromProto3Json(jsonDecode(response.body));
    } else {
      throw Exception('Failed to complete quest: ${response.statusCode}');
    }
  }
}
