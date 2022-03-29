import 'package:cloud_firestore/cloud_firestore.dart';
import '/commons/user.dart';

class Recipe {
  String id;
  String name;
  int prepTime;
  double level;
  List<String> recp;

  Map<String, dynamic> get recipeMap {
    Map<String, dynamic> recp = {
      "id": this.id,
      "name": this.name,
      "prepTime": this.prepTime,
      "level": this.level,
      "recp": this.recp,
    };
    return recp;
  }

  Recipe.fromMap(Map<String, dynamic> obj, String id) {
    print("here");
    this.id = id;
    this.name = obj["name"];
//    print(obj["prepTime"]);
    this.prepTime = obj["prepTime"].toInt();
    this.level = obj["level"].toDouble();
    List<String> r  = List<String>.from(obj["recp"]);
    this.recp = r;
  }
}

Future<List<Recipe>> getRecipes() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('Recipes').get();
  List<Recipe> recipes = [];
  qs.docs.forEach((element) {
    Recipe r = Recipe.fromMap(element.data(), element.id);
    recipes.add(r);
  });
  return recipes;
}

Future<List<Recipe>> getRecipeArchive(User obj) async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('users').doc('${obj.name}').collection('recipes').get();
  List<Recipe> recipes = [];
  qs.docs.forEach((element) {
    Recipe r = Recipe.fromMap(element.data(), element.id);
    recipes.add(r);
  });
  return recipes;
}

// TODO
Future<Recipe> RecipeOfTheDay() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('RecipeOfTheDay').get();
  Recipe r = Recipe.fromMap(qs.docs[0].data(), qs.docs[0].id);
  return r;
}