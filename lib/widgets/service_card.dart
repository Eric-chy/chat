import 'package:flutter/material.dart';
import '../models/ai_service.dart';
import '../utils/helpers.dart';

/// Card widget displaying an AI service
class ServiceCard extends StatelessWidget {
  final AIService service;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(Helpers.parseColor(service.primaryColor));

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and header
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Service icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          service.name[0],
                          style: TextStyle(
                            color: color,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Service name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            service.company,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Arrow icon
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: color,
                    ),
                  ],
                ),
              ),
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
