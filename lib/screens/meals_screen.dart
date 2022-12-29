import 'package:flutter/material.dart';
import 'package:se380_project/models/meal_model.dart';
import 'package:se380_project/models/meal_plan_model.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/recipe_screen.dart';
import 'package:se380_project/services/api_service.dart' as ApiService;
class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;
  MealsScreen({required this.mealPlan});
  @override
  _MealsScreenState createState() => _MealsScreenState();
}
class _MealsScreenState extends State<MealsScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carb: ${widget.mealPlan.carbs.toString()} cal',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);
    return GestureDetector(
      onTap: () async {
        Recipe recipe =
        await ApiService.APIService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(context,
            MaterialPageRoute(builder:  (_) => RecipeScreen(
              mealType: mealType,
              recipe: recipe,
            )));
      },
      child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 220,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(meal.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),
            Container(
              margin: EdgeInsets.all(60),
              padding: EdgeInsets.all(10),
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Text(
                    //mealtype
                    mealType,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                    ),
                  ),
                  Text(
                    //mealtitle
                    meal.title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]
      ),
    );
  }

  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //has an appBar
      appBar: AppBar(title: Text('Your Meal Plan')),
      //and body as a ListView builder
      body: ListView.builder(
        /*
        We set itemCount to 1 + no. of meals, which based on our API call,
        the no. of meals should always be 3
        */
          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (BuildContext context, int index) {
            /*
            If index is 0, we return a method called _buildTotalNutrientsCard()
            */
            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
            /*
            Otherwise, we return a buildMealCard method that takes in the meal,
            and index - 1
            */
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
}