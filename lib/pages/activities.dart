import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/activity.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_activities.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  List<Activity> activities = [];
  List<Activity> archivedActivities = [];
  Map<String, bool> arcMap;
  bool loaded = false;

  @override
  void initState() {
    getActivities().then((acts) {
      setState(() {
        activities = acts;
      });
      getActivityArchive(obj).then((arcs) {
        setState(() {
          archivedActivities = arcs;
        });
        Map<String, bool> map = actIsInArchive(acts, arcs);
        setState(() {
          arcMap = map;
          loaded = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: ActivityBackgroundLight,
      appBar: AppBar(
          backgroundColor: ActivityBackground,
          title: Text("ACTIVITIES", style: AppBarText.page,),
        elevation: 0,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                if(loaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        Widget tile = Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: arcMap[activities[index].id] ? ActivityBackgroundLight : ActivityBackground, width: 3)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                        child: Text(activities[index].name.toUpperCase(), style: CardTileText.heading.copyWith(color: Colors.white),)),
                                  ),
                                  color: arcMap[activities[index].id] ? ActivityBackgroundLight : ActivityBackground,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                                  child: Container(
                                    child: Text(activities[index].description, style: CardTileText.text,),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
//                        return tile;
                        return Card(
                          color: arcMap[activities[index].id] ? ActivityBackgroundLight : ActivityBackground,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          elevation: arcMap[activities[index].id] ? 0 : 5,
                          child: ListTile(
                            title: Text(activities[index].name.toUpperCase(),style: CardTileText.heading.copyWith(color: Colors.white),),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(activities[index].description, style: CardTileText.text,),
                            ),
                            onTap: () => navigateToDetailPage(activities[index], arcMap[activities[index].id]),
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
//            FutureBuilder(
//              future: getActivities(),
//              builder: (context, snapshot) {
//                if(snapshot.connectionState == ConnectionState.done ) {
//                  return Expanded(
//                    child: ListView.builder(
//                      itemCount: snapshot.data.length,
//                      itemBuilder: (context, index) {
//                        QueryDocumentSnapshot activity = snapshot.data[index];
//                        Map<String, dynamic> data = activity.data();
//
//                        return Card(
//                          elevation: 5.0,
//                          child: ListTile(
//                            title: Text("${activity.id.toString().toUpperCase()}",style: CardTileText.heading,),
//                            subtitle: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text("${data['description']}", style: CardTileText.text,),
//                            ),
//                            onTap: () => navigateToDetailPage(activity),
//                          ),
//                        );
//                      },
//                    ),
//                  );
//                }
//                else {
//                  return Center(child: Text("Loading..."));
//                }
//                },
//            ),
          ],
          ),
      )
    );
  }

  Map<String, bool> actIsInArchive(List<Activity> acts, List<Activity> arcs) {
    print(acts.length);
    print(arcs.length);
    Map<String, bool> res = {};
    acts.forEach((element) {
      res[element.id] = false;
    });
    arcs.forEach((element) {
      res[element.id] = true;
    });
    return res;
  }

  void navigateToDetailPage(Activity act, bool inArchive) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageActivities(activity: act, inArchive: inArchive,)));
  }

}
