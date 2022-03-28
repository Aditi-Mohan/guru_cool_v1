import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/models/activity.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_activities.dart';

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
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Activity>>(
              future: getActivityArchive(obj),
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
                else {
                  List<Activity> archive = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: archive.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1.0,
//                          color: ActivityBackgroundLight,
                          child: ListTile(
                            title: Text(
                              archive[index].name.toString().toUpperCase(),
//                              style: CardTileText.heading.copyWith(color: Colors.white),
                              style: CardTileText.heading,
                              ),
                            subtitle: Text(archive[index].description,
                              style: CardTileText.text,),
                            onTap: () => navigateToDetailPage(archive[index], true),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void navigateToDetailPage(Activity act, bool inArchive) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(activity: act, inArchive: inArchive,)));
  }

}
