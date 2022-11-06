import 'package:flutter/material.dart';
import 'package:se380_project/MainPage.dart';
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
      body: getBodyWidget(),


    );
  }
  getBodyWidget(){
    return (_currentIndex==0) ? HomePage():Container();

  }
}
