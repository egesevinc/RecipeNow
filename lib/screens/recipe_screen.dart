import 'package:flutter/material.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/favorites.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  //This stateful widget page takes in String mealType and Recipe recipe
  final String mealType;
  final Recipe recipe;
  RecipeScreen({required this.mealType, required this.recipe});
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}
class _RecipeScreenState extends State<RecipeScreen> {
  final List<Recipe> _favoriteRecipes = [];
  bool _isRecipeInFavorites(Recipe recipe){
    return _favoriteRecipes.contains(recipe);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is widget.mealType
      appBar: AppBar(
        title: Text(widget.mealType),
        actions: [
      IconButton(
      icon: _isRecipeInFavorites(widget.recipe)
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
      color: _isRecipeInFavorites(widget.recipe)
          ? Colors.red
          : Colors.white,
      onPressed: () {
        setState(() {
          if (_isRecipeInFavorites(widget.recipe)) {
            _favoriteRecipes.remove(widget.recipe);
          } else {
            _favoriteRecipes.add(widget.recipe);
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen(favoriteRecipes: _favoriteRecipes)));
        },
      ),
    );
  }
}