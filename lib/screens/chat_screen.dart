import 'package:flutter/material.dart';
import '../models/ai_service.dart';
import '../widgets/custom_webview.dart';

/// Chat screen with WebView for AI service
class ChatScreen extends StatefulWidget {
  final AIService service;

  const ChatScreen({
    super.key,
    required this.service,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomWebView(service: widget.service);
  }
}
