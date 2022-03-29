import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
    Widget body = Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
//              height: 111,
              width: MediaQuery.of(context).size.width,
              color: RecipeBackgroundLight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(widget.recipe.name.toUpperCase(), style: CardTileText.heading, textAlign: TextAlign.center,),
                  ),
                  Container(height: 10,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                children: [
                  Card(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 125,
                            width: (MediaQuery.of(context).size.width/2)-20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0, top: 20),
                                  child: Text("Difficulty", style: CardTileText.text.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),
                                ),
                                LinearPercentIndicator(
                                  width: (MediaQuery.of(context).size.width/2)-20,
                                  animation: true,
                                  lineHeight: 10.0,
                                  animationDuration: 700,
                                  percent: widget.recipe.level/10,
//                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: widget.recipe.level/10 <= 0.33 ?
                                      Color.fromRGBO(181,217,157, 1) :
                                      widget.recipe.level/10 <= 0.66 ? Color.fromRGBO(253,171,90, 1) :
                                      Color.fromRGBO(241,94,90, 1),
                                  backgroundColor: Color.fromRGBO(208,210,212, 0.5),
                                  barRadius: Radius.circular(10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text("${widget.recipe.level}/10", style: CardTileText.text.copyWith(fontSize: 14),),
                                ),
//                                Container(
//                                  height: 10,
//                                  width: (MediaQuery.of(context).size.width/2)-50,
//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.all(Radius.circular(10)),
//                                  ),
//                                  child: ClipRect(
//                                    child: LinearProgressIndicator(
//                                      backgroundColor: Color.fromRGBO(208,210,212, 0.5),
//                                      valueColor:  widget.recipe.level/10 <= 0.33 ?
//                                      AlwaysStoppedAnimation<Color>(Color.fromRGBO(181,217,157, 1),) :
//                                      widget.recipe.level/10 <= 0.66 ? AlwaysStoppedAnimation<Color>(Color.fromRGBO(253,171,90, 1),) :
//                                      AlwaysStoppedAnimation<Color>(Color.fromRGBO(241,94,90, 1),),
//                                      value: widget.recipe.level/10,
//                                    ),
//                                  ),
//                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 125,
                            width: (MediaQuery.of(context).size.width/2)-20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0, top: 20),
                                  child: Text("Time", style: CardTileText.text.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0, right: 3.0),
                                      child: Icon(
                                        Icons.alarm,
                                        size: 35,
                                        color: ReminderBackgroundLight,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: (MediaQuery.of(context).size.width/2)-90,
//                                      color: Colors.blue,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${widget.recipe.prepTime}",
                                            style: CardTileText.text.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "minutes",
                                            style: CardTileText.text.copyWith(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: RecipeBackgroundLight.withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "STEPS",
                          style: CardTileText.questionTile.copyWith(fontSize: 20, color: RecipeBackground,
//                              shadows: [Shadow(offset: Offset(0.0, 1), blurRadius: 5, color: Colors.white,),]
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height-250,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.recipe.recp.length+1,
                      itemBuilder: (context, index) {
                        if(index == widget.recipe.recp.length)
                          return Container(height: 85,);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                leading: Text("${index+1}.", style: CardTileText.text,),
                                title: Text(widget.recipe.recp[index], style: CardTileText.text,),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
    return body;
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
                child: Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: ListView.builder(
                    itemCount: widget.recipe.recp.length,
                      itemBuilder: (context, index) {
                        return Text("${widget.recipe.recp[index]}", style: DetailPageText.content,);
                      }
                      ),
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
