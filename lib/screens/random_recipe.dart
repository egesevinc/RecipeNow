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
  late Recipe _randomRecipe = Recipe(mealType: '', spoonacularSourceUrl: '', title: '');
  List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner'];
  String _selectedMealType = 'Breakfast';

  @override
  void initState() {
    super.initState();
    _fetchRandomRecipe();

  }

  _fetchRandomRecipe() async {
    _randomRecipe = await ApiService.APIService.instance.getRandomRecipe(_selectedMealType);
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
                  leading: Image.asset('assets/images/Fast-Food-image.png', width: 60, height: 60),
                  title: Text(_randomRecipe.title),
                ),
                SizedBox(
                  height: 20,
                ),

                DropdownButton<String>(
                  value: _selectedMealType,
                  items: _mealTypes.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMealType = newValue!;
                    });
                    _fetchRandomRecipe();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeScreen(
                          recipe: _randomRecipe,
                          mealType: _selectedMealType,
                        ),
                      ),
                    );
                  },
                  child: Text("View Recipe"),
                ),
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