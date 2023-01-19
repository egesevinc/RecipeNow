import "package:flutter/material.dart";
import 'dart:convert';

import 'package:se380_project/screens/CalculatorScreen.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalorieCalculatorScreen> createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  List<dynamic> _foods = [];
  String _searchQuery = "";
  List<dynamic> _selectedFoods = [];
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/Foods.json")
        .then((data){
      _foods = jsonDecode(data);
    });
  }

  List<dynamic> _getFilteredFoods() {
    if (_searchQuery.isEmpty) {
      return _foods;
    }
    return _foods.where((food) {
      return food["Column2"].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Calorie Calculator"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery=value;
                });
              },
              decoration: InputDecoration(
                  hintText: "Search for a food"
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredFoods().length,
              itemBuilder: (context,index) {
                final food = _getFilteredFoods()[index];
                return CheckboxListTile(
                  value: _selectedFoods.contains(food),
                  onChanged: (newValue){
                    setState(() {
                      if (newValue== true){
                        _selectedFoods.add(food);
                      } else {
                        _selectedFoods.remove(food);
                      }
                    });
                  },
                  title: Text(food["Column2"]),

                );
              },


            ),
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CalculatorScreen(selectedFoods: _selectedFoods),),
          );
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }
}