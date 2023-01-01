class Recipe {
  final String spoonacularSourceUrl;
  final String title;
  //equipment
  //ingredient
  // etc.

Recipe({
    required this.spoonacularSourceUrl,
   required this.title
});

  factory Recipe.fromMap(Map<String,dynamic> map){
  return Recipe(spoonacularSourceUrl: map['spoonacularSourceUrl'],
    title: map['title']
  );

  }

}