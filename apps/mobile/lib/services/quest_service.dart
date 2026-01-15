import 'package:flutter/foundation.dart';
import '../api/fof/v1/shop.pb.dart';

class QuestService extends ChangeNotifier {
  Shop? _activeQuest;

  Shop? get activeQuest => _activeQuest;

  bool get hasActiveQuest => _activeQuest != null;

  void startQuest(Shop shop) {
    _activeQuest = shop;
    notifyListeners();
  }

  void cancelQuest() {
    _activeQuest = null;
    notifyListeners();
  }
}
