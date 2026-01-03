import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

/// Service for playing audio feedback
/// Implements sound requirements from PRD (low-foley "ping" sounds)
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _soundEnabled = true;

  /// Play discovery sound when a new shop is found
  Future<void> playDiscoverySound() async {
    if (!_soundEnabled) return;
    
    try {
      // For now, use a system sound
      // In production, replace with custom audio files in assets
      await _player.play(AssetSource('sounds/discovery.mp3'));
    } catch (e) {
      debugPrint('Failed to play discovery sound: $e');
    }
  }

  /// Play quest completion sound
  Future<void> playQuestCompleteSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _player.play(AssetSource('sounds/quest_complete.mp3'));
    } catch (e) {
      debugPrint('Failed to play quest complete sound: $e');
    }
  }

  /// Play fog clearing sound
  Future<void> playFogClearSound() async {
    if (!_soundEnabled) return;
    
    try {
      await _player.play(AssetSource('sounds/fog_clear.mp3'));
    } catch (e) {
      debugPrint('Failed to play fog clear sound: $e');
    }
  }

  /// Toggle sound on/off
  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  /// Set sound enabled state
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  /// Check if sound is enabled
  bool get isSoundEnabled => _soundEnabled;

  /// Dispose audio player
  void dispose() {
    _player.dispose();
  }
}
