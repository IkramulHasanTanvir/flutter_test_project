import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

/// Automatically follows the device's system theme (Light / Dark).
/// No SharedPreferences needed — system is the single source of truth.
class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  // ─── Reactive state ──────────────────────────────────────────────────────
  final _isDark = false.obs;
  bool get isDark => _isDark.value;

  ThemeMode get themeMode => ThemeMode.system; // always system-driven

  // ─── Lifecycle ───────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _syncWithSystem();

    // React every time the OS brightness changes
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        _syncWithSystem;
  }

  @override
  void onClose() {
    // Remove listener to avoid memory leak
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
    null;
    super.onClose();
  }

  // ─── Private ─────────────────────────────────────────────────────────────
  void _syncWithSystem() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _isDark.value = brightness == Brightness.dark;
  }
}