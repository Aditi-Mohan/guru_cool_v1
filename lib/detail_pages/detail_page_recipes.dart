import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/recipe_archive.dart';

class DetailPageRecipes extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageRecipes({this.doc});

  @override
  _DetailPageRecipesState createState() => _DetailPageRecipesState();
}

class _DetailPageRecipesState extends State<DetailPageRecipes> {

  final GlobalKey<ScaffoldState> _detailPageRecipes = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      key: _detailPageRecipes,
      appBar: AppBar(
        title: Text("${data['name'].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: RecipeBackground,
      ),
      body: Card(
        elevation: 5.0,
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height - 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                height: MediaQuery.of(context).size.height - 15,
                color: RecipeBackground,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Preperation Time: ${data['prepTime']}", style: DetailPageText.sidePanel,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(thickness: 3.0, color: Colors.black38,),
                      ),
                      Text("Difficulty Level: ${data['level']}", style: DetailPageText.sidePanel,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child:Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text("${data['recp']}", style: DetailPageText.content,)
                    )
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc('${obj.name}').collection('recipes').doc('${widget.doc.id}').set({'name': data['name'], 'recp': data['recp'], 'prepTime': data['prepTime'], 'level': data['level']});
            _detailPageRecipes.currentState.showSnackBar(
              SnackBar(
                content: Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.thumb_up, color: RecipeBackground, size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Added to Archive", style: TextStyle(color: RecipeBackground, fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),),
                          )
                        ],
                      ),
                      FlatButton(
                        child: Text("View Archive", style: TextStyle(color: RecipeBackground),),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeArchive())),
                      )
                    ],
                  ),
                ),
              )
            );
          },
          label: Row(children: <Widget>[Icon(Icons.fastfood, color: Colors.white,), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Done", style: AppBarText.page,),
          )],
          ),
        backgroundColor: RecipeBackground,
      ),
    );
  }
}


class DetailPageRecipeArchive extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageRecipeArchive({this.doc});

  @override
  _DetailPageRecipeArchiveState createState() => _DetailPageRecipeArchiveState();
}

class _DetailPageRecipeArchiveState extends State<DetailPageRecipeArchive> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name'].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: RecipeBackground,
      ),
      body: Card(
          elevation: 5.0,
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height - 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: MediaQuery.of(context).size.height - 15,
                  color: RecipeBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Preperation Time: ${data['prepTime']}", style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
                        Text("Difficulty Level: ${data['level']}", style: DetailPageText.sidePanel,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child:Container(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text("${data['recp']}", style: DetailPageText.content,),
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
