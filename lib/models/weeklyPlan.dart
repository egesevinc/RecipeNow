import 'meal_model.dart';

class WeeklyPlan {
  final Map<String, Map<String, List<Meal>>> week;

  WeeklyPlan({required this.week});

  factory WeeklyPlan.fromMap(Map<String, dynamic> json) {
    Map<String, Map<String, List<Meal>>> week = {};
    for (var key in json['week'].keys) {
      var mealList = json['week'][key]['meals'] as List;
      if(mealList != null){
        List<Meal> mealsList = mealList.map((i) => Meal.fromMap(i)).toList();
        week[key] = {'meals': mealsList};
      }
    }
    return WeeklyPlan(
      week: week,
    );
  }
}