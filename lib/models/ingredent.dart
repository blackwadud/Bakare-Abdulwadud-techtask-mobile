class Ingredient {
  final String title;
  final DateTime useBy;
  bool selected;
  Ingredient({required this.title, required this.useBy,this.selected = false});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      title: json['title'],
      useBy: DateTime.parse(json['use-by']),
    );
  }
}