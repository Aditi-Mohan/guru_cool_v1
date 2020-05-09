import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/collapsing_navigation_drawer.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'package:gurucoolv1/detail_pages/detail_page_activities.dart';

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
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${snapshot.data[index].data['description']}", style: CardTileText.text,),
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
      )
    );
  }

  Future getActivities() async {
    var fire = Firestore.instance;
    QuerySnapshot qs = await fire.collection('Activities').getDocuments();
    return qs.documents;
  }

  void navigateToDetailPage( DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(doc: documentSnapshot,)));
  }

}
