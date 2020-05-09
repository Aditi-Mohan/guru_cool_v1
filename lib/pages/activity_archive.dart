import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'package:gurucoolv1/commons/user.dart';
import 'package:gurucoolv1/detail_pages/detail_page_activities.dart';

class ActivityArchive extends StatefulWidget {

  @override
  _ActivityArchiveState createState() => _ActivityArchiveState();
}

class _ActivityArchiveState extends State<ActivityArchive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ActivityBackgroundLight,
      appBar: AppBar(
        title: Text("ACTIVITY ARCHIVE", style: AppBarText.page,),
        backgroundColor: ActivityBackground,
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
                    child: Text("You haven\'t tried any Activities yet!", style: TextStyle(color: selectedColor, fontWeight: FontWeight.w900, fontSize: 30.0)),
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
                                Text("${snapshot.data[index].data['description']}", style: CardTileText.text,),
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
    var fire = Firestore.instance;
    QuerySnapshot qs = await fire.collection('users').document('${obj.name}').collection('activities').getDocuments();
    return qs.documents;
  }

  void navigateToDetailPage(DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(doc: documentSnapshot,)));
  }

}
