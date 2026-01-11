import '../models/ai_service.dart';

/// List of all supported AI services
class AIServices {
  static const List<AIService> services = [
    AIService(
      id: 'deepseek',
      name: 'DeepSeek',
      url: 'https://chat.deepseek.com/',
      iconName: 'deepseek',
      company: '深度求索',
      description: '强大的代码分析和推理能力',
      primaryColor: '#6B4DFF',
    ),
    AIService(
      id: 'kimi',
      name: 'Kimi',
      url: 'https://kimi.moonshot.cn/',
      iconName: 'kimi',
      company: '月之暗面',
      description: '超长文本处理能力',
      primaryColor: '#1E88E5',
    ),
    AIService(
      id: 'doubao',
      name: '豆包',
      url: 'https://www.doubao.com/chat/',
      iconName: 'doubao',
      company: '字节跳动',
      description: '多场景AI助手，支持编程和创作',
      primaryColor: '#00D9A6',
    ),
    AIService(
      id: 'qianwen',
      name: '通义千问',
      url: 'https://tongyi.aliyun.com/qianwen',
      iconName: 'qianwen',
      company: '阿里巴巴',
      description: '全方位AI能力，理解与创作',
      primaryColor: '#FF6B00',
    ),
    AIService(
      id: 'yuanbao',
      name: '腾讯元宝',
      url: 'https://yuanbao.tencent.com/',
      iconName: 'yuanbao',
      company: '腾讯',
      description: '混元大模型驱动，智能对话',
      primaryColor: '#00A4FF',
    ),
    AIService(
      id: 'wenxin',
      name: '文心一言',
      url: 'https://yiyan.baidu.com/',
      iconName: 'wenxin',
      company: '百度',
      description: '知识增强大语言模型',
      primaryColor: '#2932E1',
    ),
    AIService(
      id: 'chatgpt',
      name: 'ChatGPT',
      url: 'https://chatgpt.com/',
      iconName: 'chatgpt',
      company: 'OpenAI',
      description: '全球领先的AI对话助手',
      primaryColor: '#10A37F',
    ),
    AIService(
      id: 'claude',
      name: 'Claude',
      url: 'https://claude.ai/',
      iconName: 'claude',
      company: 'Anthropic',
      description: '安全、有用、诚实的AI助手',
      primaryColor: '#CC785C',
    ),
  ];

  /// Get service by ID
  static AIService? getServiceById(String id) {
    try {
      return services.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get service by URL
  static AIService? getServiceByUrl(String url) {
    try {
      return services.firstWhere((service) => url.contains(service.id));
    } catch (e) {
      return null;
    }
  }
}

/// App constants
class AppConstants {
  static const String appName = 'AI Chat Hub';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String keySessions = 'sessions';
  static const String keyDarkMode = 'darkMode';
  static const String keyLastService = 'lastService';

  // WebView settings
  static const int webViewCacheSize = 100; // MB
  static const bool webViewDebuggingEnabled = false;

  // User Agent for WebView
  static const String userAgent =
      'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
}
