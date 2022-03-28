import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/models/recipe.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_recipes.dart';

class Recipes extends StatefulWidget {

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  List<Recipe> recipes = [];
  List<Recipe> archivedRecipes = [];
  Map<String, bool> arcMap;
  bool loaded = false;

  @override
  void initState() {
    getRecipes().then((recps) {
      setState(() {
        recipes = recps;
      });
      getRecipeArchive(obj).then((arcs) {
        setState(() {
          archivedRecipes = arcs;
        });
        Map<String, bool> map = recpIsInArchive(recps, arcs);
        setState(() {
          arcMap = map;
          loaded = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecipeBackgroundLight,
      appBar: AppBar(
        title: Text('RECIPES', style: AppBarText.page,),
        backgroundColor: RecipeBackground,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar,),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                if(loaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(
                              "${recipes[index].name.toString()
                                  .toUpperCase()}",
                              style: CardTileText.heading,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.alarm, size: 18, color: ReminderBackground,),
                                    Text(" ${recipes[index].prepTime}",
                                      style: CardTileText.text,),
                                  ],
                                ),
                                Text("Difficulty Level: ${recipes[index].level}", style: CardTileText.text,)
                              ],
                            ),
                            onTap: () =>
                                navigateToDetailPage(recipes[index], arcMap[recipes[index].id]),
                          ),
                        );
                      },
                    ),
                  );
                }
                else {
                  return Center(child: Text("Loading..."));
                }
              },
            ),
//            FutureBuilder(
//              future: getRecipes(),
//              builder: (context, snapshot) {
//                if(snapshot.connectionState == ConnectionState.done ) {
//                  return Expanded(
//                    child: ListView.builder(
//                      itemCount: snapshot.data.length,
//                      itemBuilder: (context, index) {
//                        QueryDocumentSnapshot recipe = snapshot.data[index];
//                        Map<String, dynamic> data = recipe.data();
//
//                        return Card(
//                          elevation: 5.0,
//                          child: ListTile(
//                            title: Text(
//                              "${recipe.id.toString()
//                                  .toUpperCase()}",
//                              style: CardTileText.heading,),
//                            subtitle: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Row(
//                                  mainAxisSize: MainAxisSize.min,
//                                  children: [
//                                    Icon(Icons.alarm, size: 18, color: ReminderBackground,),
//                                    Text(" ${data['prepTime']}",
//                                      style: CardTileText.text,),
//                                  ],
//                                ),
//                                Text("Difficulty Level: ${data['level']}", style: CardTileText.text,)
//                              ],
//                            ),
//                            onTap: () =>
//                                navigateToDetailPage(recipe),
//                          ),
//                        );
//                      },
//                    ),
//                  );
//                }
//                else {
//                  return Center(child: Text("Loading..."));
//                }
//              },
//            ),
          ],
        ),
      ),
    );
  }
  
//  void navigateToDetailPage( DocumentSnapshot documentSnapshot) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(doc: documentSnapshot,)));
//  }

  Map<String, bool> recpIsInArchive(List<Recipe> recps, List<Recipe> arcs) {
    Map<String, bool> res = {};
    recps.forEach((element) {
      res[element.id] = false;
    });
    arcs.forEach((element) {
      res[element.id] = true;
    });
    return res;
  }

  void navigateToDetailPage(Recipe recp, bool inArchive) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(recipe: recp, inArchive: inArchive,)));
  }
}

