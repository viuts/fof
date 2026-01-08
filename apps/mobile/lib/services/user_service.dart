import 'package:flutter/material.dart';
import 'api_service.dart';
import '../api/fof/v1/user.pb.dart';
import '../api/fof/v1/visit.pb.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/achievement.pb.dart';

class UserService extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _profile;
  List<VisitedShop> _visitedShops = [];
  List<UserAchievementStatus> _achievements = [];
  bool _isLoading = false;
  bool _isInitialized = false;
  Future<void>? _initializationFuture;

  User? get profile => _profile;
  List<VisitedShop> get visitedShops => _visitedShops;
  List<Shop> get visitedShopModels => _visitedShops.map((v) => v.shop).toList();
  List<UserAchievementStatus> get achievements => _achievements;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  int get currentLevel => _profile?.level ?? 1;
  int get currentExp => _profile?.exp ?? 0;

  Future<void> loadInitialData({bool force = false}) async {
    if (_isInitialized && !force) return;
    if (_initializationFuture != null) return _initializationFuture;

    _initializationFuture = _doLoadInitialData();
    try {
      await _initializationFuture;
    } finally {
      _initializationFuture = null;
    }
  }

  Future<void> _doLoadInitialData() async {
    _isLoading = true;
    // Use microtask to avoid "setState() during build" when called from initState
    Future.microtask(() => notifyListeners());

    try {
      final futures = <Future>[
        _apiService.getProfile(),
        _apiService.getVisitedShops(),
        _apiService.getAchievements(),
      ];

      final results = await Future.wait(futures);
      _profile = (results[0] as GetProfileResponse).user;
      _visitedShops = (results[1] as GetVisitedShopsResponse).visitedShops;
      _achievements = (results[2] as GetAchievementsResponse).achievements;
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    try {
      final response = await _apiService.getProfile();
      _profile = response.user;
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing profile: $e');
    }
  }

  Future<void> refreshVisitedShops() async {
    try {
      final response = await _apiService.getVisitedShops();
      _visitedShops = response.visitedShops;
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing visited shops: $e');
    }
  }

  Future<void> refreshAchievements() async {
    try {
      final response = await _apiService.getAchievements();
      _achievements = response.achievements;
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing achievements: $e');
    }
  }

  void updateProfileData(User user) {
    _profile = user;
    notifyListeners();
  }

  void updateVisitData({required int level, required int exp}) {
    if (_profile != null) {
      _profile = _profile!.deepCopy()
        ..level = level
        ..exp = exp;
      notifyListeners();
    }
    refreshVisitedShops();
    refreshAchievements();
  }
}

extension UserProfileExtension on User {
  User deepCopy() {
    return User()..mergeFromMessage(this);
  }
}
