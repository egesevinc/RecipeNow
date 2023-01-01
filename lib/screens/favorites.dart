import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se380_project/models/recipe_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key,required this.favoriteRecipes}) : super(key: key);
  final List<Recipe> favoriteRecipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(itemCount: favoriteRecipes.length,
          itemBuilder: (context,index) {
        Recipe recipe = favoriteRecipes[index];
        return ListTile(
          title: Text(recipe.title),
        );

          }),
    );
  }
}
