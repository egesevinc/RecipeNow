class Recipe {
  final String spoonacularSourceUrl;
  final String title;
  final String mealType;
  //equipment
  //ingredient
  // etc.

Recipe({
    required this.spoonacularSourceUrl,
  required this.title,
  required this.mealType
});

  Recipe.withoutMealType({
    required this.spoonacularSourceUrl,
    required this.title,
    this.mealType = '',
  });
  factory Recipe.fromMap(Map<String,dynamic> map){
  return Recipe(spoonacularSourceUrl: map['spoonacularSourceUrl'],
    title: map['title'],
    mealType: map['mealType']
  );

  }

}