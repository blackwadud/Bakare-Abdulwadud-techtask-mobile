class Recipe {
  final String title;
  final List<String> ingredients;

  Recipe({required this.title, required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}