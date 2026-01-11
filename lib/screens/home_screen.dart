import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ai_service.dart';
import '../models/app_state.dart';
import '../utils/constants.dart';
import '../widgets/service_card.dart';
import 'chat_screen.dart';
import 'sessions_screen.dart';
import 'settings_screen.dart';

/// Home screen displaying all AI services
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ServiceSearchDelegate(AIServices.services),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '历史',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildServicesGrid();
      case 1:
        return const SessionsScreen();
      case 2:
        return const SettingsScreen();
      default:
        return _buildServicesGrid();
    }
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: AIServices.services.length,
      itemBuilder: (context, index) {
        final service = AIServices.services[index];
        return ServiceCard(
          service: service,
          onTap: () => _openService(service),
          onLongPress: () => _showServiceOptions(service),
        );
      },
    );
  }

  void _openService(AIService service) {
    context.read<AppState>().setCurrentService(service);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(service: service),
      ),
    );
  }

  void _showServiceOptions(AIService service) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('打开服务'),
              onTap: () {
                Navigator.pop(context);
                _openService(service);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('关于'),
              onTap: () {
                Navigator.pop(context);
                _showServiceInfo(service);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceInfo(AIService service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(service.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('公司', service.company),
            const SizedBox(height: 8),
            _buildInfoRow('描述', service.description),
            const SizedBox(height: 8),
            _buildInfoRow('网址', service.url),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }
}

/// Search delegate for searching AI services
class ServiceSearchDelegate extends SearchDelegate<String> {
  final List<AIService> services;

  ServiceSearchDelegate(this.services);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = query.isEmpty
        ? <AIService>[]
        : services.where((service) {
            final nameLower = service.name.toLowerCase();
            final companyLower = service.company.toLowerCase();
            final descLower = service.description.toLowerCase();
            final queryLower = query.toLowerCase();
            return nameLower.contains(queryLower) ||
                companyLower.contains(queryLower) ||
                descLower.contains(queryLower);
          }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final service = results[index];
        return ServiceCard(
          service: service,
          onTap: () {
            close(context, service.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(service: service),
              ),
            );
          },
        );
      },
    );
  }
}
