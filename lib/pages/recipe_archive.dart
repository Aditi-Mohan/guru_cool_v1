import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_recipes.dart';
import '/models/recipe.dart';

class RecipeArchive extends StatefulWidget {

  @override
  _RecipeArchiveState createState() => _RecipeArchiveState();
}

class _RecipeArchiveState extends State<RecipeArchive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecipeBackgroundLight,
      appBar: AppBar(
        title: Text("RECIPE ARCHIVE", style: AppBarText.page,),
        backgroundColor: RecipeBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Recipe>>(
              future: getRecipeArchive(obj),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: Text("Loading..."),
                  );
                else if(snapshot.data.length == 0)
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("You haven\'t tried any Recipes yet! ", style: TextStyle(color: selectedColor, fontWeight: FontWeight.w900, fontSize: 30)),
                  ));
                else {
                  List<Recipe> recipes = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return Card(
//                          elevation: 5.0,
                          child: ListTile(
                            title: Text("${recipes[index].name.toString().toUpperCase()}",
                              style: CardTileText.heading,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.alarm, size: 18, color: ReminderBackground,),
                                    Text(" ${recipes[index].prepTime} minutes",
                                      style: CardTileText.text,),
                                  ],
                                ),
                                Text("Difficulty: ${recipes[index].level}",
                                  style: CardTileText.text,)
                              ],
                            ),
                            onTap: () => navigateToDetailPage(recipes[index], true),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void navigateToDetailPage(Recipe recp, bool inArchive) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(recipe: recp, inArchive: inArchive)));
  }

}
