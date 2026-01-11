/// Chat Session model for tracking conversation history
class ChatSession {
  final String id;
  final String serviceId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatSession({
    required this.id,
    required this.serviceId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  ChatSession copyWith({
    String? id,
    String? serviceId,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatSession(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] as String,
      serviceId: json['serviceId'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
