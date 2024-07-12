
class Tag {
  final int  id;
  final int  score;
  final String? libelle;

  Tag({required this.id,required this.score, required this.libelle});

  // Method to convert UserRegisterDto object to JSON
  Map<String, dynamic> toBody() {
    return {
      'id': id,
      'libelle': libelle,
      'score': score,
    };
  }

  // Static method to create UserRegisterDto object from JSON
  static Tag fromBody(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      score: json['score'],
      libelle: json['libelle'],
    );
  }
}