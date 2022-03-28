import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/recipe_archive.dart';
import '/models/recipe.dart';

class DetailPageRecipes extends StatefulWidget {

  final Recipe recipe;
  final bool inArchive;


  DetailPageRecipes({this.recipe, this.inArchive});

  @override
  _DetailPageRecipesState createState() => _DetailPageRecipesState();
}

class _DetailPageRecipesState extends State<DetailPageRecipes> {

  final GlobalKey<ScaffoldState> _detailPageRecipes = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _detailPageRecipes,
      appBar: AppBar(
        title: Text(
          widget.recipe.name.toUpperCase(),
          style: AppBarText.detailPage,
        ),
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
                      Text("Preperation Time: ${widget.recipe.prepTime}", style: DetailPageText.sidePanel,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(thickness: 3.0, color: Colors.black38,),
                      ),
                      Text("Difficulty Level: ${widget.recipe.level}", style: DetailPageText.sidePanel,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child:Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text("${widget.recipe.recp}", style: DetailPageText.content,)
                    )
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc('${obj.name}').collection('recipes')
                .doc('${widget.recipe.id}').set({
                  'name': widget.recipe.name,
                  'recp': widget.recipe.recp,
                  'prepTime': widget.recipe.prepTime,
                  'level': widget.recipe.level
                });
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
          label: Row(
            children: [
              !widget.inArchive ? Icon(Icons.fastfood, color: Colors.white,) : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    // TODO: CHANGE TEXT OF BUTTON
                    if(widget.inArchive) return Text("Completed");
                    return Text("Complete", style: AppBarText.page,);
                  }
                ),
              )
            ],
          ),
        backgroundColor: widget.inArchive ? RecipeBackgroundLight : RecipeBackground,
      ),
    );
  }
}
