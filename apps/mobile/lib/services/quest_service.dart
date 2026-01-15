import 'package:flutter/foundation.dart';
import '../api/fof/v1/shop.pb.dart';
import '../api/fof/v1/quest.pb.dart';
import 'api_service.dart';

class QuestService extends ChangeNotifier {
  Quest? _activeQuest;
  final ApiService _apiService = ApiService();

  Shop? get activeQuest =>
      _activeQuest?.hasShop() == true ? _activeQuest!.shop : null;
  Quest? get currentQuest => _activeQuest;

  bool get hasActiveQuest => _activeQuest != null;

  Future<void> loadActiveQuest() async {
    try {
      final response = await _apiService.getActiveQuest();
      if (response.hasActiveQuest) {
        _activeQuest = response.quest;
      } else {
        _activeQuest = null;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load active quest: $e');
    }
  }

  void setQuest(Quest quest) {
    _activeQuest = quest;
    notifyListeners();
  }

  Future<void> cancelQuest() async {
    if (_activeQuest == null) return;

    try {
      await _apiService.cancelQuest(_activeQuest!.id);
      _activeQuest = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to cancel quest: $e');
      // Optimistically clear locally or handle error as needed
      // For now, we keep it consistent with UI expectations
      _activeQuest = null;
      notifyListeners();
    }
  }

  Future<void> completeQuest() async {
    if (_activeQuest == null) return;

    try {
      await _apiService.completeQuest(_activeQuest!.id);
      _activeQuest = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to complete quest: $e');
    }
  }
}
