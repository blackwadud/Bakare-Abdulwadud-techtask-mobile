import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/screens/recipe_selection.dart';
import '../provider/app_services.dart';

class IngredientSelection extends StatefulWidget {
  @override
  State<IngredientSelection> createState() => _IngredientSelectionState();
}

class _IngredientSelectionState extends State<IngredientSelection> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select prefered lunch date'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<AppServices>().fetchIngredients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred'));
          } else {
            return Consumer<AppServices>(
              builder: (context, recipeProvider, child) {
                final ingredients = recipeProvider.ingredients;
                return ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = ingredients[index];
                    if (ingredient.useBy.isBefore(selectedDate)) {
                      return ListTile(
                        title: Text(ingredient.title),
                        subtitle: Text('Expired'),
                        enabled: false,
                      );
                    }else {
                      return CheckboxListTile(
                        title: Text(ingredient.title),
                        subtitle: Text(ingredient.useBy.toString()),
                        value: ingredient.selected,
                        onChanged: (bool? value) {
                          recipeProvider.toggleIngredientSelection(index);
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final selectedIngredients = context
              .read<AppServices>()
              .ingredients
              .where((ingredient) => ingredient.selected)
              .map((ingredient) => ingredient.title)
              .toList();
          print(
              'Selected Ingredients: $selectedIngredients'); // Add this line for debugging purposes

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RecipeListScreen(selectedIngredients: selectedIngredients),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
