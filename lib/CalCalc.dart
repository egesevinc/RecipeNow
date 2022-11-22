import 'package:flutter/material.dart';
import 'homePage.dart';
class CalCalc extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Calculator();
  }

}

class Calculator extends State<CalCalc> {
  var _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("RecipeNow"),
      ),
      backgroundColor: Colors.green,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Calorie calculator"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
      body: getBodyWidget(),


    );
  }
  getBodyWidget(){
    return (_currentIndex==0) ? CalCalc():Container();

  }
}


















import 'package:flutter/material.dart';
 class calcalcPage extends StatelessWidget{
 @override
   Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white54,
     body: Center(
       child: (Image.asset('assets/images/calculator.png')
       )
     )
     );


 }


 }
