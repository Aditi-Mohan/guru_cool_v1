import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/detail_pages/detail_page_recipes.dart';

class Recipes extends StatefulWidget {

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {


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
            FutureBuilder(
              future: getRecipes(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done ) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot recipe = snapshot.data[index];
                        Map<String, dynamic> data = recipe.data();

                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(
                              "${recipe.id.toString()
                                  .toUpperCase()}",
                              style: CardTileText.heading,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.alarm, size: 18, color: ReminderBackground,),
                                    Text(" ${data['prepTime']}",
                                      style: CardTileText.text,),
                                  ],
                                ),
                                Text("Difficulty Level: ${data['level']}", style: CardTileText.text,)
                              ],
                            ),
                            onTap: () =>
                                navigateToDetailPage(recipe),
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
          ],
        ),
      ),
    );
  }

  Future getRecipes() async {
    
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('Recipes').get();
    return qs.docs;
  }
  
  void navigateToDetailPage( DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(doc: documentSnapshot,)));
  }

}

