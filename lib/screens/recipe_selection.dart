import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/provider/app_services.dart';

class RecipeListScreen extends StatelessWidget {
  final List<String> selectedIngredients;

  RecipeListScreen({required this.selectedIngredients}) {
    print(
        'Selected ingredients in RecipeListScreen: $selectedIngredients');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: FutureBuilder(
        future: context.read<AppServices>().fetchRecipes(selectedIngredients),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred'));
          } else {
            return Consumer<AppServices>(
              builder: (context, recipeProvider, child) {
                final recipes = recipeProvider.recipes;
                return ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return ListTile(
                      title: Text(recipe.title),
                      subtitle: Text(recipe.ingredients.join(', ')),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
