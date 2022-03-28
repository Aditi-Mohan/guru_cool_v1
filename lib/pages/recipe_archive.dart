import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_recipes.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getRecipes(),
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
                else
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
            )
          ],
        ),
      ),
    );
  }

  Future getRecipes() async {
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('users').doc('${obj.name}').collection('recipes').get();
    return qs.docs;
  }

  void navigateToDetailPage(DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageRecipes(doc: documentSnapshot,)));
  }

}
