import 'package:flutter/material.dart';
import 'package:se380_project/screens/Calculator.dart';
import 'package:se380_project/screens/search_screen.dart';
import 'main.dart';
import 'package:se380_project/screens/search_ingredient_screen.dart';
class HomePage extends StatelessWidget{

  var services = [
    "Search",
    "Calorie Calculator",
    "Search by Ingredient",
    "Diet",
    "Meal Suggestion",
    "Favorites",
  ];

  var images = [
    "assets/images/searchImage.png",
    "assets/images/calculator.png",
    "assets/images/ingredient.jpg",
    "assets/images/diet.png",
    "assets/images/suggestion.png",
    "assets/images/fav.jpg",


  ];
  var pages = [
    SearchScreen(),
    LoginWidget(onClickedSignup: () => null),
    SearchIngredient(),
    CalculatorScreen(),
    SearchScreen(),
    SearchScreen(),
    SearchScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
      child: GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2.6)
          ),
          itemBuilder: (BuildContext context,int index){
            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(images[index] , height: 50,width: 50,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> pages[index])),
                      child: Text(services[index], style: TextStyle(fontSize: 16,fontFamily:"Montserrat",color:Colors.black,height:1.2,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                    ),
                  ),
                  )

                ],
              ),
            );
          }
      ),);
  }

}