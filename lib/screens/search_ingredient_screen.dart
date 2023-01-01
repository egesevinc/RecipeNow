import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/recipe_screen.dart';
import 'package:se380_project/services/api_service.dart';
import 'package:se380_project/models/recipe_search_result.dart';

class SearchIngredient extends StatefulWidget {
  const SearchIngredient({Key? key}) : super(key: key);

  @override
  State<SearchIngredient> createState() => _SearchIngredientState();
}

class _SearchIngredientState extends State<SearchIngredient> {
  final TextEditingController _ingredientController = TextEditingController();
  List _recipes = [];

  Future<void> _searchRecipes() async {
    final recipes = await APIService.instance.searchRecipesByIngredient(ingredient: _ingredientController.text);
    setState(() {
      _recipes = recipes;
    });
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _ingredientController,
            decoration: InputDecoration(
              hintText: 'Enter an ingredient',
            ),
          ),
          ElevatedButton(
            onPressed: _searchRecipes,
            child: Text('Search'),
          ),
          Expanded(
            child: FutureBuilder(
              future: APIService.instance.searchRecipesByIngredient(
                ingredient: _ingredientController.text,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Recipetest recipe = snapshot.data![index];
                      Recipe convertedRecipe = Recipe(
                        title: recipe.title,
                        spoonacularSourceUrl: recipe.imageUrl,
                        // ... other properties
                      );
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the recipe screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeScreen(
                                recipe: convertedRecipe, mealType: 'Lunch',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: ListTile(
                            title: Text(recipe.title),
                            leading: Image.network(recipe.imageUrl),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
