class RecipeSearchResult{
final List<Recipetest> recipes;

RecipeSearchResult({required this.recipes});

factory RecipeSearchResult.fromMap(List<dynamic> data){
  List<Recipetest> recipes = [];

  for(var item in data){
    recipes.add(Recipetest.fromMap(item));
  }
  return RecipeSearchResult(
    recipes: recipes,
  );
}

}
class Recipetest{
  final int id;
  final String title;
  final String imageUrl;

  Recipetest({required this.id,required this.title,required this.imageUrl});

  factory Recipetest.fromMap(Map<String,dynamic> data){
    return Recipetest(
      id: data['id'],
      title: data['title'],
      imageUrl: data['image']
    );
  }
}