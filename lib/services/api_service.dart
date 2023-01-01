import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se380_project/models/meal_plan_model.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/models/recipe_search_result.dart';

import '../models/NutritionInfo.dart';
class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY = 'c96f02ff96bf4b15949521a9bcdc3e1c';

  Future<MealPlan> generateMealPlan({required int targetCalories, required String diet}) async{
    if (diet == 'None') diet='';
    Map<String, String> parameters = {
      'timeFrame': 'day', //to get 3 meals
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/mealplans/generate',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }
  //  int number=10,int offset=0
  Future<List<Recipetest>> searchRecipesByIngredient({required String ingredient,int number=10,int offset=0}) async {
    Map<String, String> parameters = {
      'ingredients': ingredient,
      'number': number.toString(),
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
        _baseUrl,
        'recipes/findByIngredients',
        parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    //debugger();

    try {
      var response = await http.get(uri,headers: headers);
      List<dynamic> data = json.decode(response.body);
      RecipeSearchResult searchResult = RecipeSearchResult.fromMap(data);
      return searchResult.recipes;
    }catch (err) {
      throw err.toString();
    }

  }

  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/information',
      parameters,
    );Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try{
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    }catch (err) {
      throw err.toString();
    }
  }
  // getting Future<Recipe> GetNutritions(String id) async

  Future<NutritionInfo?> getNutritionInfo( {required String food}) async {
    Map<String, String> parameters = {
      'food': food,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      'recipes/$food/nutritionWidget',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: '.json',
    };

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map rJson = jsonDecode(response.body);
      NutritionInfo recipecalorie = NutritionInfo.fromJson(rJson);
      return recipecalorie;
    }
  }
  }
