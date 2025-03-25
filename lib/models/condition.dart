class Condition {
  final String id;
  final String name;
  final String category;
  final String description;
  final String prevalence;
  final List<String> symptoms;
  final List<String> treatments;
  final String severity;
  final String imageUrl;

  Condition({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.prevalence,
    required this.symptoms,
    required this.treatments,
    required this.severity,
    required this.imageUrl,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      prevalence: json['prevalence'],
      symptoms: List<String>.from(json['symptoms']),
      treatments: List<String>.from(json['treatments']),
      severity: json['severity'],
      imageUrl: json['imageUrl'],
    );
  }
}