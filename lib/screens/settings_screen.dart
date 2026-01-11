import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';
import '../services/cookie_service.dart';

/// Settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<AppState>().isDarkMode;

    return ListView(
      children: [
        // Appearance section
        _buildSectionHeader('外观'),
        _buildSwitchTile(
          context,
          icon: Icons.dark_mode,
          title: '暗黑模式',
          subtitle: '开启深色主题',
          value: isDarkMode,
          onChanged: (value) {
            context.read<AppState>().toggleDarkMode();
            StorageService().saveDarkMode(value);
          },
        ),

        const Divider(height: 32),

        // Storage section
        _buildSectionHeader('存储'),
        _buildActionTile(
          context,
          icon: Icons.delete_outline,
          title: '清除历史记录',
          subtitle: '删除所有会话历史',
          onTap: () => _clearSessions(context),
        ),
        _buildActionTile(
          context,
          icon: Icons.cookie_outlined,
          title: '清除登录状态',
          subtitle: '清除所有AI服务的登录Cookie',
          onTap: () => _clearCookies(context),
        ),
        _buildActionTile(
          context,
          icon: Icons.delete_sweep,
          title: '清除所有数据',
          subtitle: '清除历史记录和登录状态',
          onTap: () => _clearAll(context),
          color: Colors.red,
        ),

        const Divider(height: 32),

        // About section
        _buildSectionHeader('关于'),
        _buildInfoTile(
          context,
          icon: Icons.info_outline,
          title: '应用版本',
          subtitle: '${AppConstants.appName} ${AppConstants.appVersion}',
        ),
        _buildActionTile(
          context,
          icon: Icons.description_outlined,
          title: '使用说明',
          subtitle: '查看应用使用指南',
          onTap: () => _showUsageGuide(context),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
      secondary: Icon(icon),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Future<void> _clearSessions(BuildContext context) async {
    final confirmed = await _showConfirmDialog(
      context,
      title: '清除历史记录',
      content: '确定要删除所有会话历史吗？此操作不可撤销。',
    );

    if (confirmed == true && context.mounted) {
      await StorageService().clearSessions();
      // ignore: use_build_context_synchronously
      context.read<AppState>().setSessions([]);
      // ignore: use_build_context_synchronously
      _showSnackBar(context, '历史记录已清除');
    }
  }

  Future<void> _clearCookies(BuildContext context) async {
    final confirmed = await _showConfirmDialog(
      context,
      title: '清除登录状态',
      content: '确定要清除所有AI服务的登录状态吗？您需要重新登录各服务。',
    );

    if (confirmed == true) {
      await CookieService().clearAllCookies();

      if (context.mounted) {
        _showSnackBar(context, '登录状态已清除');
      }
    }
  }

  Future<void> _clearAll(BuildContext context) async {
    final confirmed = await _showConfirmDialog(
      context,
      title: '清除所有数据',
      content: '确定要清除所有数据吗？包括历史记录和登录状态。此操作不可撤销。',
    );

    if (confirmed == true && context.mounted) {
      await StorageService().clearAll();
      await CookieService().clearAllCookies();
      // ignore: use_build_context_synchronously
      context.read<AppState>().setSessions([]);
      // ignore: use_build_context_synchronously
      _showSnackBar(context, '所有数据已清除');
    }
  }

  void _showUsageGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('使用说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '欢迎使用AI Chat Hub！',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '功能特点：',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• 集成8个主流AI聊天服务'),
              Text('• 保持各服务登录状态'),
              Text('• 记录访问历史'),
              Text('• 支持暗黑模式'),
              SizedBox(height: 16),
              Text(
                '使用方法：',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('1. 在首页选择想要使用的AI服务'),
              Text('2. 首次使用需要在服务页面登录'),
              Text('3. 登录后会自动保持登录状态'),
              Text('4. 在"历史"标签查看访问记录'),
              SizedBox(height: 16),
              Text(
                '注意事项：',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• 本应用通过WebView嵌入各AI服务网页版'),
              Text('• 数据和聊天记录由各AI服务商保存'),
              Text('• 建议在WiFi环境下使用以节省流量'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
