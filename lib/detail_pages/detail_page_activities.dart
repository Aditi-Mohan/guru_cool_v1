import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/activity.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/activity_archive.dart';

class DetailPageActivities extends StatefulWidget {

  final Activity activity;
  final bool inArchive;

  DetailPageActivities({this.activity, this.inArchive});

  @override
  _DetailPageActivitiesState createState() => _DetailPageActivitiesState();
}

class _DetailPageActivitiesState extends State<DetailPageActivities> {

  final GlobalKey<ScaffoldState> _detailPageActivities = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _detailPageActivities,
      appBar: AppBar(
        title: Text(widget.activity.name.toUpperCase(), style: AppBarText.detailPage,),
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
                        Text(widget.activity.description, style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
                        Text("Goal Of the Activity: \n ${widget.activity.goal}", style: DetailPageText.sidePanel,),
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
                        Text(widget.activity.deets, style: DetailPageText.content),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc('${obj.name}')
                .collection('activities').doc('${widget.activity.id}')
                .set({
                  'deets': widget.activity.deets,
                  'description': widget.activity.description,
                  'goal': widget.activity.goal,
                  'name': widget.activity.name
                });
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
          label: Row(
                children: [
                  !widget.inArchive ? Icon(Icons.done_outline, color: Colors.white,) : Container(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                        builder: (context) {
                          if(widget.inArchive) return Text("Completed", style: AppBarText.page,);
                          else return Text("Complete", style: AppBarText.page,);
                        }
                        ),
                  ),
                ],
              ),
        backgroundColor: widget.inArchive ? ActivityBackgroundLight : ActivityBackground,
      ),
    );
  }
}
