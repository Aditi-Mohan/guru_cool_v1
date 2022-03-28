import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/pages/home_page.dart';
import '/models/activity.dart';
import '/commons/archive_view.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_activities.dart';

class NewHomePage extends StatefulWidget {

  final bool showSnackBarOnEntry;

  NewHomePage({this.showSnackBarOnEntry = false});

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  final GlobalKey<ScaffoldState> _HomePage = new GlobalKey<ScaffoldState>();

  Future _question;
  Future<Activity> _activity;
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
      appBar: AppBar(
        title: Text("GURUCOOL", style: AppBarText.page,),
        backgroundColor: HomepageBackground,
        elevation: 0,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'entery',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: HomepageBackground, width: 2.5),
                      color: Colors.white
                  ),
                  child: FutureBuilder(
                    future: _question,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        QueryDocumentSnapshot q = snapshot.data[0];
                        Map<String, dynamic> data = q.data();

                        return Container(
                          height: 280,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.extension, size: 30, color: HomepageBackground),
                                            ),
                                            Text("Question Of The Day",
                                              style: CardTileText.questionTile.copyWith(color: HomepageBackground),),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text("${q.id}", style: ListTileText.black.copyWith(color: Colors.black54),),
                                      ),
                                    )
                                  ],
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
                                      errorText: _validate
                                          ? "Answer cannot be empty"
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  color: HomepageBackground,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Text("Submit",
                                        style: ListTileText.white.copyWith(color: Colors.white),),
                                    ],
                                  ),
                                  onPressed: () {
                                    FocusScopeNode currentFocus = FocusScope
                                        .of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    answer();
                                    if (!_validate) {
                                      FirebaseFirestore.instance.collection(
                                          'users')
                                          .doc('${obj.name}').collection(
                                          'answers').doc(
                                          '${q.id}')
                                          .set({'answer': _answer.text});
                                      _answer.clear();
                                      _HomePage.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Your Answer has been Submitted!",
                                              style: TextStyle(
                                                  color: HomepageBackground,
                                                  fontWeight: FontWeight
                                                      .w600,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle
                                                      .italic),
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
                      }
                      else {
                        return Container(
                          height: 280,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.extension, size: 30, color: HomepageBackground),
                                            ),
                                            Text("Question Of The Day",
                                              style: CardTileText.questionTile.copyWith(color: HomepageBackground),),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text("Loading...", style: ListTileText.black.copyWith(color: Colors.black54),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder<Activity>(
              future: _activity,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  Activity task = snapshot.data;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) =>
                          DetailPageActivities(activity: task, inArchive: false,)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-10,
                      decoration: BoxDecoration(
                        color: HomepageBackgroundLight,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width-10,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.8,
                                child: Image.asset("assets/scenery.png"),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.lightbulb_outline, color: Colors.white,),
                                        ),
                                        Text("Today\'s Activity", style: AppBarText.page,),
                                      ],
                                    ),
                                    Builder(
                                        builder: (context) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("${task.id}",
                                                  style: ListTileText.white.copyWith(fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(
                                                    offset: Offset(0.0, 1),
                                                    blurRadius: 5,
                                                    color: HomepageBackground,
                                                  ),]),),
                                              ),
                                            );
                                          }
                                          else {
                                            return Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Loading...",
                                                  style: ListTileText.white,),
                                              ),
                                            );
                                          }
                                        }
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else return Container();
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18.0, 8.0, 0.0, 0.0),
                          child: Text("ARCHIVES", style: CardTileText.questionTile.copyWith(fontSize: 24, color: HomepageBackground,),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
//                      color: HomepageBackgroundLight,
                          child: ArchiveView()
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getQuestion() async {
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('QuestionOfTheDay').get();
    return qs.docs;
  }
}
