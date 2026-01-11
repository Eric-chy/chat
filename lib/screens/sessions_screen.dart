import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/ai_service.dart';
import '../utils/constants.dart';
import '../widgets/session_item.dart';
import 'chat_screen.dart';

/// Sessions screen displaying chat history
class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = context.watch<AppState>().sessions;

    if (sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无历史记录',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        final service = AIServices.getServiceById(session.serviceId);

        if (service == null) return const SizedBox.shrink();

        return SessionItem(
          session: session,
          serviceName: service.name,
          onTap: () => _openSession(context, service),
          onDelete: () => _deleteSession(context, session),
        );
      },
    );
  }

  void _openSession(BuildContext context, AIService service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(service: service),
      ),
    );
  }

  void _deleteSession(BuildContext context, session) {
    context.read<AppState>().removeSession(session.id);

    // Also remove from storage
    final updatedSessions = context.read<AppState>().sessions;
    _saveSessions(context, updatedSessions);
  }

  Future<void> _saveSessions(BuildContext context, List<dynamic> sessions) async {
    // This will be handled by storage service
    // For now, just update the state
  }
}
