import 'package:flutter/material.dart';
import 'package:se380_project/models/meal_model.dart';
import 'package:se380_project/models/meal_plan_model.dart';
import 'package:se380_project/services/api_service.dart' as ApiService;
import 'meals_screen.dart';
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}
class _CalculatorScreenState extends State<CalculatorScreen> {

  @override
//This method generates a MealPlan by parsing our parameters into the
  //ApiService.instance.generateMealPlan.
  //It then pushes the Meal Screen onto the stack with Navigator.push
  void _searchNutritions() async {
    //çalışmıyor
    //getNutritions.api part
  }
  Widget build(BuildContext context) {
    /*
    Our build method returns Scaffold Container, which has a decoration
    image using a Network Image. The image loads and is the background of
    the page
    */
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/arkaplan3.jpg"),
            fit: BoxFit.cover

          ),
        ),
//Center widget and a container as a child, and a column widget
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView(
              children: <Widget>[
                //Text widget for our app's title
                const Text(
                  'Calorie Calculator',
                  style: TextStyle(fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                //space
                const SizedBox(height: 20),
                //A RichText to style the target calories

                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Type here",
                    labelText: 'Food name ',
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                  },
                )
                ,



                SizedBox(
                  height: 400,
                 // child: AnimatedList(


                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
