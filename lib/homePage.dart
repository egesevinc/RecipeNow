import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  var services = [
    "Search",
    "Edit1",
    "Edit2",
    "Edit3",
    "Edit4",
    "Edit4",
    "Edit4",
    "Edit4"
  ];

  var images = [
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",
    "assets/images/adornment.png",


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
                    height: 20,
                  ),
                  Image.asset(images[index] , height: 50,width: 50,),
                  Padding(
                      padding: EdgeInsets.all(20), child:Text(services[index], style: TextStyle(fontSize: 16,fontFamily:"Montserrat",color:Colors.black,height:1.2,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)
                  )
                ],
              ),
            );
          }
      ),);
  }

}