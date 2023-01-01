class NutritionInfo {
  int calories = 0;
  String carbs ='';
  String fat ='';
  String protein ='';

  Map weightPerServing ={}; //bu recipede var ingredientte yok

  NutritionInfo.fromJson(Map json) {
    this.calories = json['calories'];
    this.protein = json['protein'];
    this.fat = json['fat'];
    this.carbs = json['carbs'];
    this.weightPerServing=json["weightPerServing"];

  }
}
