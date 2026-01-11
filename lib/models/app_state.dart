import 'package:flutter/material.dart';
import 'ai_service.dart';
import 'chat_session.dart';

/// Global application state
class AppState extends ChangeNotifier {
  List<ChatSession> _sessions = [];
  AIService? _currentService;
  bool _isDarkMode = false;

  List<ChatSession> get sessions => _sessions;
  AIService? get currentService => _currentService;
  bool get isDarkMode => _isDarkMode;

  void setSessions(List<ChatSession> sessions) {
    _sessions = sessions;
    notifyListeners();
  }

  void addSession(ChatSession session) {
    _sessions.insert(0, session);
    notifyListeners();
  }

  void removeSession(String sessionId) {
    _sessions.removeWhere((s) => s.id == sessionId);
    notifyListeners();
  }

  void updateSession(ChatSession session) {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _sessions[index] = session;
      notifyListeners();
    }
  }

  void setCurrentService(AIService? service) {
    _currentService = service;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  List<ChatSession> getSessionsByService(String serviceId) {
    return _sessions.where((s) => s.serviceId == serviceId).toList();
  }
}
