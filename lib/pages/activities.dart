import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/detail_pages/detail_page_activities.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ActivityBackgroundLight,
      appBar: AppBar(backgroundColor: ActivityBackground, title: Text("ACTIVITIES", style: AppBarText.page,)),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getActivities(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done ) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot activity = snapshot.data[index];
                        Map<String, dynamic> data = activity.data();

                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text("${activity.id.toString().toUpperCase()}",style: CardTileText.heading,),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${data['description']}", style: CardTileText.text,),
                            ),
                            onTap: () => navigateToDetailPage(activity),
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
      )
    );
  }

  Future getActivities() async {
    print("here");
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('Activities').get();
    return qs.docs;
  }

  void navigateToDetailPage( DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(doc: documentSnapshot,)));
  }

}
