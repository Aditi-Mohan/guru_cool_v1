import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/collapsing_navigation_drawer.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'package:gurucoolv1/commons/user.dart';
import 'package:gurucoolv1/detail_pages/detail_page_activities.dart';

class Reminder extends StatefulWidget {

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {

  final GlobalKey<ScaffoldState> _Reminder = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _Reminder,
      backgroundColor: ReminderBackgroundLight,
      appBar: AppBar(
        title: Text("Reminders", style: AppBarText.page,),
        backgroundColor: ReminderBackground,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getTodaysActivity(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: Text("Loading..."),);
                else
                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      title: Text("Today\'s Activity", style: CardTileText.heading,),
                      subtitle: Text("${snapshot.data[0].documentID}", style: CardTileText.text,),
                      onTap: () => navigateToDetailPage(snapshot.data[0]),
                    ),
                  );
              },
            ),
            FutureBuilder(
              future: getReminders(),
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
                        child: ExpansionTile(
                          leading: Icon(Icons.alarm),
                          title: Text("${snapshot.data[index].documentID.toString().toUpperCase()}",style: CardTileText.heading,),
                          children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${snapshot.data[index].data['description']}", style: CardTileText.text,),
                                    ),
                                    FlatButton(
                                      child: Text("Done"),
                                      onPressed: () async {
                                        int currCount = 0;
                                        DocumentSnapshot doc = await Firestore.instance.collection('users').document('${obj.name}').collection('DailyTasks').document('${snapshot.data[index].documentID}').get();
                                        if(doc.exists) {
                                          currCount += doc.data['count'];
                                          Firestore.instance.collection('users').document(
                                              '${obj.name}')
                                              .collection('DailyTasks')
                                              .document('${snapshot.data[index].documentID}')
                                              .setData({'count': currCount + 1});
                                        }
                                        else
                                          Firestore.instance.collection('users').document(
                                              '${obj.name}')
                                              .collection('DailyTasks')
                                              .document('${snapshot.data[index].documentID}')
                                              .setData({'count': currCount + 1});
                                        _Reminder.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text("Task Completed, Well Done!", style: TextStyle(color: ReminderBackground),),
                                            )
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          ],
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

  Future getReminders() async {
    var fire = Firestore.instance;
    QuerySnapshot qs = await fire.collection('Reminders').getDocuments();
    return qs.documents;
  }

  Future getTodaysActivity() async {
  var fire = Firestore.instance;
  QuerySnapshot qs = await fire.collection('Today\'sActivity').getDocuments();
  return qs.documents;
  }

  void navigateToDetailPage(DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(doc: documentSnapshot,)));
  }

}
