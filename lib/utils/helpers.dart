import 'dart:convert';

/// Helper functions for the app
class Helpers {
  /// Parse color from hex string
  static int parseColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return int.parse('FF$hex', radix: 16);
  }

  /// Format date time for display
  static String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    }
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Encode to base64
  static String base64Encode(String input) {
    final bytes = utf8.encode(input);
    return base64.encode(bytes);
  }

  /// Decode from base64
  static String base64Decode(String input) {
    final bytes = base64.decode(input);
    return utf8.decode(bytes);
  }

  /// Validate URL
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
