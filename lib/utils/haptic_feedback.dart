import 'package:flutter/services.dart';

class AppHaptics {
  static bool _enabled = true;

  static void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  static bool get isEnabled => _enabled;

  /// Light tap for button presses and selections
  static Future<void> lightTap() async {
    if (!_enabled) return;
    await HapticFeedback.lightImpact();
  }

  /// Medium tap for important actions
  static Future<void> mediumTap() async {
    if (!_enabled) return;
    await HapticFeedback.mediumImpact();
  }

  /// Gentle vibration for phase transitions in breathing exercises
  static Future<void> breathingPhaseChange() async {
    if (!_enabled) return;
    await HapticFeedback.selectionClick();
  }

  /// Success feedback for completing an exercise
  static Future<void> exerciseComplete() async {
    if (!_enabled) return;
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }

  /// Subtle tick for counting or steps
  static Future<void> tick() async {
    if (!_enabled) return;
    await HapticFeedback.selectionClick();
  }
}
