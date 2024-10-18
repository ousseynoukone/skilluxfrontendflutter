class Ressource {
  final int id;
  final String? title;
  final String? text;
  final String? headerImage;

  Ressource({
    required this.id,
    this.title,
    this.text,
    this.headerImage,
  });

  // Factory method to create a Ressource from a Map (e.g., from JSON)
  factory Ressource.fromBody(Map<String, dynamic> json) {
    return Ressource(
      id: json['id'] as int,
      title: json['title'] as String?,
      text: json['text'] as String?,
      headerImage: json['headerImage'] as String?,
    );
  }
}
