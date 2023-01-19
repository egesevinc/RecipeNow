import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _height = 0;
  double _weight = 0;
  double _bmi = 0;
  String _bmiResult = "";
  String _bmiImage = " ";

  void _calculateBMI() {
    setState(() {
      _bmi = _weight / (_height * _height)*10000;
      if (_bmi < 18.5) {
        _bmiResult = "Underweight";
        _bmiImage = "assets/images/Under.png";
      } else if (_bmi >= 18.5 && _bmi <= 22.9) {
        _bmiResult = "Normal weight";
        _bmiImage = "assets/images/Normal.png";
      } else if (_bmi >= 23 && _bmi <= 24.9) {
        _bmiResult = "Risk to overweight";
        _bmiImage = "assets/images/Risky.png";
      } else if (_bmi >= 25 && _bmi <= 29.9) {
        _bmiResult = "Overweight";
        _bmiImage = "assets/images/Over.png";
      } else {
        _bmiResult = "Obesity";
        _bmiImage = "assets/images/Obese.png";

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Height (cm)"),
                    onChanged: (value) {
                      setState(() {
                        _height = double.parse(value);
                      });
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Weight (kg)"),
                    onChanged: (value) {
                      setState(() {
                        _weight = double.parse(value);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text("Calculate"),
                    onPressed: _calculateBMI,
                  ),
                  Text("BMI: $_bmi"),
                  Text("Result: $_bmiResult"),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 410,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(_bmiImage),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.bottomCenter)),
            ),
          ],
        ),
      ),


    );
  }
}
