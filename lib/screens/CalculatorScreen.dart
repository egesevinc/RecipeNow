import 'package:flutter/material.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/models/recipe_search_result.dart';
import 'package:se380_project/screens/CalorieCalculatorScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalculatorScreen extends StatefulWidget {
  List<Recipetest> selectedfoods;

  CalculatorScreen({ required this.selectedfoods});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}
class _CalculatorScreenState extends State<CalculatorScreen> {


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

      ),
    );
  }
}