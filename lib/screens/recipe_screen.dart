import 'package:flutter/material.dart';
import 'package:se380_project/main.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/favorites.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RecipeScreen extends StatefulWidget {
  //This stateful widget page takes in String mealType and Recipe recipe
  final String mealType;
  final Recipe recipe;
  RecipeScreen({required this.mealType, required this.recipe});
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}
class _RecipeScreenState extends State<RecipeScreen> {

  bool _isRecipeInFavorites(RecipeList recipeList,Recipe recipe) {
    return recipeList.recipes.contains(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeList>(
        builder: (context,recipeList,child){
          bool isRecipeInFavorites =_isRecipeInFavorites(recipeList,widget.recipe);

          return Scaffold(
            //AppBar is widget.mealType
            appBar: AppBar(
              title: Text(widget.mealType),
              actions: [
                IconButton(
                  icon: isRecipeInFavorites
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: isRecipeInFavorites
                      ? Colors.red
                      : Colors.white,
                  onPressed: () {
                    setState(() {
                      if (isRecipeInFavorites) {
                        recipeList.removeRecipe(widget.recipe);
                        FirebaseFirestore.instance.collection("favorites").doc(widget.recipe.title).delete();
                      } else {
                        recipeList.addRecipe(widget.recipe);
                        FirebaseFirestore.instance.collection("favorites").add({
                          "recipeId": FirebaseFirestore.instance.collection("favorites").doc().id,
                          "title": widget.recipe.title,
                        });
                      }
                    });
                  },
                )
              ],
            ),
        /**
         * Body is a Webview. Ensure you have imported webview flutter.
         *
         * initialUrl- spoonacularSourceUrl of our parsed in recipe
         * javascriptMode - set to unrestricted so as JS can load in the webview
         */
        body: WebView(
          initialUrl: widget.recipe.spoonacularSourceUrl,
          //JS unrestricted, so that JS can execute in the webview
          javascriptMode: JavascriptMode.unrestricted,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
            BottomNavigationBarItem(
              icon: Icon(Icons.web),
              label: 'WebView',
            ),
          ],
          onTap: (index){
            Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen(favoriteRecipes: recipeList.recipes)));
          },
        ),
      );
    }
    );
  }
}