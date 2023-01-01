import 'package:flutter/material.dart';
import 'package:se380_project/models/CalCalc.dart';
import 'package:se380_project/MainPage.dart';
import 'package:se380_project/screens/CalculatorScreen.dart';
import 'package:se380_project/screens/CalorieCalculatorScreen.dart';
import 'package:se380_project/screens/search_screen.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }

}

class _MainState extends State<MainPage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("RecipeNow"),
      ),
      backgroundColor: Color(0xFFF0F0F0),

      body: Padding(
        padding: EdgeInsets.only(top:15),
        child: getBodyWidget(),
      ),


    );
  }
  getBodyWidget(){
    if(_currentIndex==0) {return HomePage(); }
    if(_currentIndex==2) {return CalorieCalculatorScreen(); }
    if(_currentIndex==1) {return SearchScreen(); }
    if(_currentIndex==3) {return HomePage(); }

  }

}
