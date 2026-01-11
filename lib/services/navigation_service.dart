import 'package:flutter/material.dart';

/// Navigation service for managing app navigation
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a named route
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Replace current route
  Future<dynamic> replaceWith(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate back
  void goBack([dynamic result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    }
  }

  /// Check if can go back
  bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }
}
