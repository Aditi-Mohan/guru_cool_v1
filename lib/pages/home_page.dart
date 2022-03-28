import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/archive_view.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_activities.dart';


class HomePage extends StatefulWidget {

  final bool showSnackBarOnEntry;

  HomePage({this.showSnackBarOnEntry = false});

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _HomePage = new GlobalKey<ScaffoldState>();

  Future _question;
  Future _activity;
  TextEditingController _answer = new TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _question = getQuestion();
    _activity = getTodaysActivity();
    if(widget.showSnackBarOnEntry)
      WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar());
  }

  void showSnackBar() async {
    await Future.delayed(Duration(seconds: 2));
    _HomePage.currentState.showSnackBar(
      SnackBar(
        content: Text("Welcome Back ${obj.name.toUpperCase()} !", style: TextStyle(color: HomepageBackground, fontSize:25.0, fontWeight: FontWeight.w900, fontFamily: 'Alpha'),),
      )
    );
  }

  void answer() {
    setState(() {
      if(_answer.text.isEmpty)
        _validate = true;
      else
        _validate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _HomePage,
      backgroundColor: HomepageBackgroundLight,
      appBar: AppBar(title: Text("GURUCOOL", style: AppBarText.page,), backgroundColor: HomepageBackground,),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'entery',
                  child: Card(
                      elevation: 5.0,
                      child: FutureBuilder(
                        future: _question,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting)
                            return Center(
                              child: Text("Loading..."),
                            );
                          else
                            return Container(
                              height: 280,
                              child: Column(
                                    children: <Widget>[
//                                Divider(
//                                  thickness: 3.0,
//                                ),
                                      ListTile(
                                        leading: Icon(Icons.extension, size: 30,),
                                        title: Text("Question Of The Day", style: CardTileText.questionTile,),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${snapshot.data[0].documentID}", style: ListTileText.black,),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            maxLines: 5,
                                            controller: _answer,
                                            decoration: InputDecoration(
//                                        border: OutlineInputBorder(
//                                          borderSide: BorderSide(color: Colors.lightBlueAccent),
//                                        ),
//                                        errorBorder: OutlineInputBorder(
//                                          borderSide: BorderSide(color: Colors.red),
//                                        ),
                                              errorText: _validate?"Answer cannot be empty":null,
                                            ),
                                          ),
                                        ),
                                      ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                              color: HomepageBackground,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("Submit", style: ListTileText.white,),
                                                ],
                                              ),
                                              onPressed: () {
                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                if (!currentFocus.hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                answer();
                                                if(!_validate) {
                                                  FirebaseFirestore.instance.collection('users')
                                                      .doc('${obj.name}').collection(
                                                      'answers').doc(
                                                      '${snapshot.data[0].documentID}')
                                                      .set({'answer': _answer.text});
                                                  _answer.clear();
                                                  _HomePage.currentState.showSnackBar(
                                                    SnackBar(
                                                      content: Text("Your Answer has been Submitted!", style: TextStyle(color: HomepageBackground, fontWeight: FontWeight.w600, fontSize: 20.0, fontStyle: FontStyle.italic),
                                                      ),
                                                    )
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                    ],
                                  ),
                            );
                        },
                      ),
                    ),
                ),
              ),
            Card(
              elevation: 5.0,
              color: ReminderBackground,
              child: FutureBuilder(
                future: _activity,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: Text("Loading..."),
                    );
                  else
                    return ListTile(
                      leading: Icon(Icons.lightbulb_outline, color: Colors.white,),
                      title: Text("Today\'s Activity", style: AppBarText.page,),
                      subtitle: Text("${snapshot.data[0].documentID}", style: ListTileText.white,),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(doc: snapshot.data[0],))),
                    );
                },
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 4.0),
                          child: Text("Archives", style: AppBarText.page,),
                        ),
                      ],
                    ),
                    ArchiveView()
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future getTodaysActivity() async {
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('Today\'sActivity').get();
    return qs.docs;
  }

  Future getQuestion() async {
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('QuestionOfTheDay').get();
    return qs.docs;
  }
}

//TODO: Change Background color
//TODO: Profile Pic