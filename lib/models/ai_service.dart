/// AI Service model representing a chat AI provider
class AIService {
  final String id;
  final String name;
  final String url;
  final String iconName;
  final String company;
  final String description;
  final String primaryColor;

  const AIService({
    required this.id,
    required this.name,
    required this.url,
    required this.iconName,
    required this.company,
    required this.description,
    required this.primaryColor,
  });

  AIService copyWith({
    String? id,
    String? name,
    String? url,
    String? iconName,
    String? company,
    String? description,
    String? primaryColor,
  }) {
    return AIService(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      iconName: iconName ?? this.iconName,
      company: company ?? this.company,
      description: description ?? this.description,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
