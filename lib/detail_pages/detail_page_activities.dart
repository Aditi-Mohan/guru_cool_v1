import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/activity_archive.dart';

class DetailPageActivities extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageActivities({this.doc});

  @override
  _DetailPageActivitiesState createState() => _DetailPageActivitiesState();
}

class _DetailPageActivitiesState extends State<DetailPageActivities> {

  final GlobalKey<ScaffoldState> _detailPageActivities = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      key: _detailPageActivities,
      appBar: AppBar(
        title: Text("${data["name"].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: ActivityBackground,
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
                  color: ActivityBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${data['description']}", style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
                        Text("Goal Of the Activity: \n ${data['goal']}", style: DetailPageText.sidePanel,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child:
                        Text("${data['deets']}", style: DetailPageText.content),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc('${obj.name}').collection('activities').doc('${widget.doc.id}').set({'deets': data['deets'], 'description': data['description'], 'goal': data['goal'], 'name': data['name']});
            _detailPageActivities.currentState.showSnackBar(
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
                            child: Icon(Icons.thumb_up, color: ActivityBackground, size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Added to Archive", style: TextStyle(color: ActivityBackground, fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),),
                          )
                        ],
                      ),
                      FlatButton(
                        child: Text("View Archive", style: TextStyle(color: ActivityBackground),),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityArchive())),
                      )
                    ],
                  ),
                ),
              )
            );
          },
          label: Row(children: <Widget>[Icon(Icons.done_outline, color: Colors.white,), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Completed", style: AppBarText.page,),
          )],
          ),
        backgroundColor: ActivityBackground,
      ),
    );
  }
}


class DetailPageActivityArchive extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageActivityArchive({this.doc});

  @override
  _DetailPageActivityArchiveState createState() => _DetailPageActivityArchiveState();
}

class _DetailPageActivityArchiveState extends State<DetailPageActivityArchive> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name'].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: ActivityBackground,
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
                  color: ActivityBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${data['description']}", style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
                        Text("Goal Of the Activity: \n ${data['goal']}", style: DetailPageText.sidePanel,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child:
                      Text("${data['deets']}", style: DetailPageText.content, maxLines: 15,),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
