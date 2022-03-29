import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/activity.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/activity_archive.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class DetailPageActivities extends StatefulWidget {

  final Activity activity;
  bool inArchive;

  DetailPageActivities({this.activity, this.inArchive});

  @override
  _DetailPageActivitiesState createState() => _DetailPageActivitiesState();
}

class _DetailPageActivitiesState extends State<DetailPageActivities> {

  final GlobalKey<ScaffoldState> _detailPageActivities = new GlobalKey<ScaffoldState>();
  ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      key: _detailPageActivities,
      body: Stack(
        children: [
          Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
//              height: 111,
                  width: MediaQuery.of(context).size.width,
                  color: ActivityBackgroundLight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(widget.activity.name.toUpperCase(), style: CardTileText.heading, textAlign: TextAlign.center,),
                      ),
                      Container(height: 10,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: ListTile(
                    leading: Icon(
                      Icons.description,
                      color: ActivityBackgroundLight,
                    ),
                    title: Text(widget.activity.description, style: CardTileText.text,),
                  ),
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width-10,
                    height: 130,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width-10,
                          height: 130,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(245,144,139, 1),
                              image: DecorationImage(image: AssetImage("assets/goal.png"), fit: BoxFit.contain, alignment: Alignment.topLeft)
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width-150,
                            height: 130,
                            child: Center(
                              child: Text(
                                  widget.activity.goal, style: DetailPageText.sidePanel.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: ActivityBackground, width: 10,)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 18.0, bottom: 6.0),
                          child: Row(
                            children: [
                              Text("DETAILS", style: CardTileText.questionTile.copyWith(fontSize: 20, color: ActivityBackground,),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                            child: Text(widget.activity.deets, style: CardTileText.text,),
                          ),
                        ),
                        Container(height: 70,),
                      ],
                    ),
                  ),
                ),
//            Card(
//              shadowColor: HomepageBackground,
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//              elevation: 3.0,
//              semanticContainer: true,
//              clipBehavior: Clip.antiAliasWithSaveLayer,
//              child: Stack(
//                children: <Widget>[
//                  Positioned.fill(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        image: DecorationImage(image: AssetImage("assets/goal.png"), fit: BoxFit.cover),
//                      ),
//                      child: Container(
//                        color: Colors.transparent.withOpacity(0.3),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            ListTile(
//                              title: Text("Title", style: AppBarText.page,),
//                              subtitle: Text("subtitle", style: ListTileText.white,),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
              ],
            ),
          ),
        ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
              emissionFrequency: 0.2,
              shouldLoop: false, // start again as soon as the animation is finished
              maxBlastForce: 21,
              minBlastForce: 20,
              maximumSize: Size(30, 30),
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
      ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(widget.inArchive) return;
          _controllerCenter.play();
          FirebaseFirestore.instance.collection('users').doc('${obj.name}')
              .collection('activities').doc('${widget.activity.id}')
              .set(widget.activity.activityMap);
          setState(() {
            widget.inArchive = true;
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
//                          Padding(
//                            padding: const EdgeInsets.all(3.0),
//                            child: Icon(Icons.thumb_up, color: ActivityBackground, size: 16,),
//                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Added to Archive", style: TextStyle(color: ActivityBackground, fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),),
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
    return body;
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
