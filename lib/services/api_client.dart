import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ingredent.dart';
import '../models/reciepe.dart';
import 'exceptions.dart';


class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<List<Ingredient>> fetchIngredients() async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/ingredients'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((ingredient) => Ingredient.fromJson(ingredient)).toList();
      } else if(response.statusCode == 400){
        throw CustomExceptions(message: 'Bad request, Please select Ingredients again');
      }else{
        throw CustomExceptions(message: ' Failed to load ingredients');
      }
    }on http.ClientException catch (e) {
      throw CustomExceptions(message: 'Network error: ${e.message}');
    } catch (e) {
      throw CustomExceptions(message: 'Error: ${e.toString()}');
    }
  }

  Future<List<Recipe>> fetchRecipes(List<String> ingredients) async {
    try{
      final query = ingredients.join(',');
      final response = await http.get(Uri.parse('$baseUrl/recipes?ingredients=$query'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else if(response.statusCode == 400){
        throw CustomExceptions(message:'Bad request');
      }else {
        throw CustomExceptions(message:'Failed to load recipes');
      }
    }on http.ClientException catch (e) {
      throw CustomExceptions(message: 'Network error: ${e.message}');
    } catch (e) {
      throw CustomExceptions(message: 'Error: ${e.toString()}');
    }

  }
}
