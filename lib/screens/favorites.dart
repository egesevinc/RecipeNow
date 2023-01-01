import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se380_project/main.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:provider/provider.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key,required this.favoriteRecipes}) : super(key: key);
  final List<Recipe> favoriteRecipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Consumer<RecipeList>(
        builder: (context,recipeList,_) {
          return ListView.builder(itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = favoriteRecipes[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 20),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border.all(
                          color: Colors.indigo,
                          width: 1
                        ),
                      ),
                      child: ListTile(
                        title: Text(recipe.title,style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                );
              });
        }
      ),
    );
  }
}
