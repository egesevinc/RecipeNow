import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:se380_project/models/recipe_model.dart';
import 'package:se380_project/screens/meals_screen.dart';
import 'package:se380_project/screens/recipe_screen.dart';
import 'package:se380_project/services/api_service.dart' as ApiService;

import '../models/meal_model.dart';

class DietPlanPage extends StatefulWidget {
  @override
  _DietPlanPageState createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  Map<String, Map<String, List<Meal>>> _weeklyPlan = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeeklyPlan();
  }

  _fetchWeeklyPlan() async {
    setState(() {
      _loading = true;
    });
    var weeklyPlan = await ApiService.APIService.instance.getWeeklyPlan();
    if (weeklyPlan != null) {
      setState(() {
        _weeklyPlan = weeklyPlan.week;
        _loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Weekly Meal Plan",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _weeklyPlan != null
                      ? ListView.builder(
                    itemCount: _weeklyPlan.length,
                    itemBuilder: (context, index) {
                      var day = _weeklyPlan.keys.elementAt(index);
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              day,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                              ),
                            ),
                          ),
                          Divider(),
                          ...(_weeklyPlan[day]!['meals'] as List<Meal>).map((meal) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: Image.asset('assets/images/meal-food-image.png', width: 60, height: 60),
                              title: Text(meal.title),
                              subtitle: Text(meal.id.toString()),
                            ),
                          )).toList()
                        ],
                      );
                    },
                  )
                      : CircularProgressIndicator(),
              ),
                SizedBox(height: 20),

            ],
          ),
        ),
      )
    );
  }
}