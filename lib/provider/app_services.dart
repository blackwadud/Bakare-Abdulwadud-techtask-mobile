import 'package:flutter/foundation.dart';

import '../models/ingredent.dart';
import '../models/reciepe.dart';
import '../services/api_client.dart';


class AppServices with ChangeNotifier {
  final ApiClient apiClient;
  List<Ingredient> _ingredients = [];
  List<Recipe> _recipes = [];

  AppServices({required this.apiClient});

  List<Ingredient> get ingredients => _ingredients;
  List<Recipe> get recipes => _recipes;

  Future<void> fetchIngredients() async {
    _ingredients = await apiClient.fetchIngredients();
    notifyListeners();
  }

  Future<void> fetchRecipes(List<String> selectedIngredients) async {
    _recipes = await apiClient.fetchRecipes(selectedIngredients);
    notifyListeners();
  }
}
