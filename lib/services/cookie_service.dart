import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Cookie management service for maintaining login states
class CookieService {
  static final CookieService _instance = CookieService._internal();
  factory CookieService() => _instance;
  CookieService._internal();

  /// Initialize cookie manager
  Future<void> init() async {
    // Cookie manager initializes automatically on first use
  }

  /// Get all cookies for a specific URL
  Future<List<Cookie>> getCookies(String url) async {
    final CookieManager manager = CookieManager.instance();
    final cookies = await manager.getCookies(url: WebUri(url));
    return cookies;
  }

  /// Clear all cookies for a specific domain
  Future<void> clearCookiesForDomain(String domain) async {
    final CookieManager manager = CookieManager.instance();
    await manager.deleteAllCookies();
  }

  /// Clear all cookies
  Future<void> clearAllCookies() async {
    final CookieManager manager = CookieManager.instance();
    await manager.deleteAllCookies();
  }

  /// Check if has cookies for a service
  Future<bool> hasCookiesForService(String serviceUrl) async {
    final cookies = await getCookies(serviceUrl);
    return cookies.isNotEmpty;
  }
}
