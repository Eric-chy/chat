import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_session.dart';
import '../utils/constants.dart';

/// Storage service for persisting app data
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  /// Initialize storage service
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save sessions
  Future<void> saveSessions(List<ChatSession> sessions) async {
    await init();
    final sessionsJson = sessions.map((s) => s.toJson()).toList();
    await _prefs!.setString(AppConstants.keySessions, jsonEncode(sessionsJson));
  }

  /// Load sessions
  Future<List<ChatSession>> loadSessions() async {
    await init();
    final sessionsString = _prefs!.getString(AppConstants.keySessions);
    if (sessionsString == null) return [];

    final sessionsJson = jsonDecode(sessionsString) as List;
    return sessionsJson
        .map((json) => ChatSession.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Save dark mode preference
  Future<void> saveDarkMode(bool isDarkMode) async {
    await init();
    await _prefs!.setBool(AppConstants.keyDarkMode, isDarkMode);
  }

  /// Load dark mode preference
  Future<bool> loadDarkMode() async {
    await init();
    return _prefs!.getBool(AppConstants.keyDarkMode) ?? false;
  }

  /// Save last used service
  Future<void> saveLastService(String serviceId) async {
    await init();
    await _prefs!.setString(AppConstants.keyLastService, serviceId);
  }

  /// Load last used service
  Future<String?> loadLastService() async {
    await init();
    return _prefs!.getString(AppConstants.keyLastService);
  }

  /// Clear all data
  Future<void> clearAll() async {
    await init();
    await _prefs!.clear();
  }

  /// Clear sessions only
  Future<void> clearSessions() async {
    await init();
    await _prefs!.remove(AppConstants.keySessions);
  }
}
