import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:se380_project/services/api_service.dart' as ApiService;
import 'package:se380_project/models/NutritionInfo.dart';
import 'package:se380_project/screens/CalculatorScreen.dart';
import '../models/recipe_search_result.dart';
import '../services/api_service.dart';
//import 'package:se380_project//widgets/food_list.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final TextEditingController _foodController = TextEditingController();
  List<Recipetest> _selectedfoods = [];

  List _recipes = [];


  Future<void> _recipeCalorie() async {
    final recipeCalories = await APIService.instance.getNutritionInfo(food : _foodController.text);
    print(NutritionInfo);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _foodController,
            decoration: InputDecoration(
              hintText: 'Enter food name',
            ),
          ),
          ElevatedButton(
            onPressed: _recipeCalorie,
            child: Text('Search'),
          ),
          Expanded(
            child: FutureBuilder(
              future: APIService.instance.searchRecipesByIngredient(
                ingredient: _foodController.text,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Recipetest recipe = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedfoods.add(recipe);
                          });
                          // Navigate to the recipe screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CalculatorScreen(
                                selectedfoods: _selectedfoods,
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
                      return ListTile(
                        title: Text(recipe.title),
                        leading: Image.network(recipe.imageUrl),
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
