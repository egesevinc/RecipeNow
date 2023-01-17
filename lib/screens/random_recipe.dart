import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:se380_project/models/meal_model.dart';
import 'package:se380_project/models/meal_plan_model.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/recipe_screen.dart';
import 'package:se380_project/services/api_service.dart' as ApiService;

class RandomRecipePage extends StatefulWidget {
  @override
  _RandomRecipePageState createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  late Recipe _randomRecipe;
  late String _mealType;

  @override
  void initState() {
    super.initState();
    _fetchRandomRecipe();
  }

  _fetchRandomRecipe() async {
    _randomRecipe=Recipe(spoonacularSourceUrl: "spoonacularSourceUrl", title: "title", mealType: "mealType");
    _randomRecipe = await ApiService.APIService.instance.getRandomRecipe();
    setState(() {});
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: _randomRecipe != null
          ? Center(
        child: Container(
          width: 350,
          height: 450,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 15),
                    blurRadius: 15),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -10),
                    blurRadius: 10)
              ]),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text(_randomRecipe.title),
                  subtitle: Text(_randomRecipe.spoonacularSourceUrl),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeScreen(
                          recipe: _randomRecipe,
                          mealType: 'Breakfast', //example value
                        ),
                      ),
                    );
                  },
                  child: Text("View Recipe"),
                )
              ],
            ),
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}