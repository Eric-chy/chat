import 'package:flutter/material.dart';
import '../models/chat_session.dart';
import '../utils/helpers.dart';

/// List item widget for a chat session
class SessionItem extends StatelessWidget {
  final ChatSession session;
  final String serviceName;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const SessionItem({
    super.key,
    required this.session,
    required this.serviceName,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(session.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              serviceName[0],
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            session.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            serviceName,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Helpers.formatDateTime(session.updatedAt),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
