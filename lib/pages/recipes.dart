import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/collapsing_navigation_drawer.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'package:gurucoolv1/detail_pages/detail_page_recipes.dart';

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
                if(snapshot.connectionState == ConnectionState.waiting ) {
                  return Center(child: Text("Loading..."));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5.0,
                        child: ListTile(
                          title: Text("${snapshot.data[index].documentID.toString().toUpperCase()}",style: CardTileText.heading,),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Preperation Time: ${snapshot.data[index].data['prepTime']}", style: CardTileText.text,),
                              Text("Difficulty Level: ${snapshot.data[index].data['level']}", style: CardTileText.text,)
                            ],
                          ),
                          onTap: () => navigateToDetailPage(snapshot.data[index]),
                        ),
                      );
                      },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getRecipes() async {
    
    var fire = Firestore.instance;
    QuerySnapshot qs = await fire.collection('Recipes').getDocuments();
    return qs.documents;
  }
  
  void navigateToDetailPage( DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(doc: documentSnapshot,)));
  }

}

