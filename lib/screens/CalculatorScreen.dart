import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:se380_project/screens/CalorieCalculatorScreen.dart';

class CalculatorScreen extends StatefulWidget {
  final List<dynamic> selectedFoods;

  CalculatorScreen({required this.selectedFoods});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<double> _amounts = [];
  @override
  void initState() {
    super.initState();
    if(widget.selectedFoods.length > 0) _amounts = List.generate(widget.selectedFoods.length, (_) => 100);
  }

  int _getTotalCalories() {
    double total = 0;
    if (widget.selectedFoods.length > 0) {
      final calories = _amounts.asMap().entries.map((e) => e.value /100 *
          widget.selectedFoods[e.key]["Column5"]).toList();
      total = calories.fold(0, (sum, element) => sum + element);
    }
    return total.round();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Calorie Calculator")),
        body:
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.selectedFoods.length,
                  itemBuilder: (context,index) {
                    final food = widget.selectedFoods[index];
                    return ListTile(
                      title: Text(food["Column2"]),
                      subtitle: Text("Calories: ${food["Column5"] * _amounts[index] / 100}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 150,
                            child: Slider(
                              value: _amounts[index],
                              onChanged: (double newValue) {
                                setState(() {
                                  _amounts[index] = newValue;
                                });
                              },
                              min: 0,
                              max: 1000,
                              divisions: 100,
                              label: '${_amounts[index].round()} ',
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('${_amounts[index].round()} g'),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                widget.selectedFoods.removeAt(index);
                                _amounts.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(food["Column2"]),
                              content: Text("\nCategory: ${food["Column4"]} \nProtein: ${food["Column6"]* _amounts[index].round() / 100} g \nCarbohydrate: ${food["Column7"]* _amounts[index].round() / 100} g \nFat: ${food["Column10"]* _amounts[index].round() / 100} g\nSugar: ${food["Column8"]* _amounts[index].round() / 100} g\nCalcium: ${food["Column38"]* _amounts[index].round() / 100} mg \nIron: ${food["Column41"]* _amounts[index].round() / 100} mg \nMagnesium: ${food["Column40"]* _amounts[index].round() / 100} mg \nPhosphorus: ${food["Column39"]* _amounts[index].round() / 100} mg \nPotassium: ${food["Column45"]* _amounts[index].round() / 100} mg \nSodium: ${food["Column46"]* _amounts[index].round() / 100} mg \nZinc: ${food["Column42"]* _amounts[index].round() / 100} mg \nCholesterol: ${food["Column39"]* _amounts[index].round() / 100} mg \nAlcohol: ${food["Column49"]* _amounts[index].round() / 100} g"),
                              actions: [
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },

                    );

                  }
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Click on foods for the nutrient details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                color: Colors.greenAccent,
                child: Text(
                  "Total Calories: ${_getTotalCalories()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
            ),

          ],
        )


    );
  }
}
