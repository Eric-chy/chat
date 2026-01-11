import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../models/ai_service.dart';
import '../utils/constants.dart';

/// Custom WebView widget for displaying AI service pages
class CustomWebView extends StatefulWidget {
  final AIService service;

  const CustomWebView({
    super.key,
    required this.service,
  });

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  InAppWebViewController? _webViewController;
  double _loadingProgress = 0;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final color = Color(_parseColor(widget.service.primaryColor));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.service.name,
              style: const TextStyle(fontSize: 18),
            ),
            if (_isLoading)
              Text(
                '加载中... ${(_loadingProgress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 12),
              )
            else
              Text(
                widget.service.company,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        backgroundColor: color,
        foregroundColor: Colors.white,
        actions: [
          // Reload button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController?.reload();
            },
          ),
          // More options
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'home':
                  _webViewController?.loadUrl(
                    urlRequest: URLRequest(url: WebUri(widget.service.url)),
                  );
                  break;
                case 'forward':
                  _webViewController?.goForward();
                  break;
                case 'back':
                  _webViewController?.goBack();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'home',
                child: Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(width: 8),
                    Text('返回首页'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'forward',
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward),
                    SizedBox(width: 8),
                    Text('前进'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'back',
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 8),
                    Text('后退'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.service.url)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              databaseEnabled: true,
              cacheEnabled: true,
              userAgent: AppConstants.userAgent,
              useShouldOverrideUrlLoading: true,
              useOnDownloadStart: true,
              mediaPlaybackRequiresUserGesture: false,
              allowFileAccess: true,
              allowContentAccess: true,
              supportZoom: true,
              builtInZoomControls: false,
              disableContextMenu: false,
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                _loadingProgress = progress / 100;
              });
            },
            onReceivedError: (controller, request, error) {
              setState(() {
                _isLoading = false;
              });
              _showErrorSnackBar(error.description);
            },
          ),
          if (_isLoading)
            LinearProgressIndicator(
              value: _loadingProgress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String? message) {
    if (mounted && message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('加载错误: $message'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: '重试',
            textColor: Colors.white,
            onPressed: () {
              _webViewController?.reload();
            },
          ),
        ),
      );
    }
  }

  int _parseColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return int.parse('FF$hex', radix: 16);
  }
}
