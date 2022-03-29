import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/models/activity.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_activities.dart';
import '/models/reminder.dart';

class Reminders extends StatefulWidget {

  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {

  final GlobalKey<ScaffoldState> _Reminder = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _Reminder,
      backgroundColor: ReminderBackgroundLight,
      appBar: AppBar(
        title: Text("Reminders", style: AppBarText.page,),
        backgroundColor: ReminderBackground,
        elevation: 0,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Container(
//              color: ReminderBackgroundLight,
                child:
                FutureBuilder<Activity>(
                    future: getTodaysActivity(),
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
//              FutureBuilder<Activity>(
//                future: getTodaysActivity(),
//                builder: (context, snapshot) {
//                  if(snapshot.connectionState == ConnectionState.done) {
//                    Activity activity = snapshot.data;
//                    return Card(
//                      elevation: 5.0,
//                      child: ListTile(
//                        title: Text(
//                          "Today\'s Activity", style: CardTileText.heading,),
//                        subtitle: Text("${activity.name}",
//                          style: CardTileText.text,),
//                        onTap: () => navigateToDetailPage(activity),
//                      ),
//                    );
//                  }
//                  else {
//                    return Center(child: Text("Loading..."),);
//                  }
//                },
//              ),
              ),
            ),
            Container(height: 10,),
            FutureBuilder<List<Reminder>>(
              future: getReminders(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done ) {
                  List<Reminder> rems = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: rems.length,
                      itemBuilder: (context, index) {
                        return Card(
//                          elevation: 5.0,
                          child: ExpansionTile(
                            leading: Icon(Icons.alarm, color: ReminderBackgroundLight,),
                            title: Text(
                              "${rems[index].title.toString()
                                  .toUpperCase()}",
                              style: CardTileText.heading,),
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(rems[index].description,
                                      style: CardTileText.text,),
                                  ),
                                  FlatButton(
                                    child: Text("Done"),
                                    onPressed: () async {
                                      int currCount = 0;
                                      DocumentSnapshot doc = await FirebaseFirestore
                                          .instance.collection('users').doc(
                                          '${obj.name}').collection(
                                          'DailyTasks')
                                          .doc(
                                          '${rems[index].id}')
                                          .get();
                                      if (doc.exists) {
                                        Map<String, dynamic> data = doc.data();
                                        currCount += data['count'];
                                        FirebaseFirestore.instance.collection(
                                            'users').doc(
                                            '${obj.name}')
                                            .collection('DailyTasks')
                                            .doc('${rems[index].id}')
                                            .set({'count': currCount + 1});
                                      }
                                      else
                                        FirebaseFirestore.instance.collection(
                                            'users').doc(
                                            '${obj.name}')
                                            .collection('DailyTasks')
                                            .doc('${rems[index].id}')
                                            .set({'count': currCount + 1});
                                      _Reminder.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Task Completed, Well Done!",
                                              style: TextStyle(
                                                  color: ReminderBackground),),
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
//
//  Future getReminders() async {
//    var fire = FirebaseFirestore.instance;
//    QuerySnapshot qs = await fire.collection('Reminders').get();
//    return qs.docs;
//  }

//  Future getTodaysActivity() async {
//  var fire = FirebaseFirestore.instance;
//  QuerySnapshot qs = await fire.collection('Today\'sActivity').get();
//  return qs.docs;
//  }

  void navigateToDetailPage(Activity act) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(activity: act, inArchive: false,)));
  }

}
