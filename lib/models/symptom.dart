class Symptom {
  final String id;
  final String name;
  final String category;
  final String description;
  final String severity;
  final List<String> relatedConditions;
  final List<String> treatments;
  final String imageUrl;

  Symptom({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.severity,
    required this.relatedConditions,
    required this.treatments,
    required this.imageUrl,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      severity: json['severity'],
      relatedConditions: List<String>.from(json['relatedConditions']),
      treatments: List<String>.from(json['treatments']),
      imageUrl: json['imageUrl'],
    );
  }
}