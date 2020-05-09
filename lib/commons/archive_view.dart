import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/navigation_model.dart';
import 'package:gurucoolv1/commons/theme.dart';

class ArchiveView extends StatefulWidget {
  @override
  _ArchiveViewState createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {

  int curr =0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      child: PageView.builder(
          itemCount: archives.length,
          controller: PageController(viewportFraction: 0.69),
          onPageChanged: (counter) {
            setState(() {
              curr = counter;
            });
          },
          itemBuilder: (context, counter) {
            return Transform.scale(
              scale: curr == counter?1:0.8,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: curr == counter?10.0:3.0,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("${archives[counter].image}"), fit: BoxFit.cover),
                          ),
                          child: Container(
                            color: Colors.transparent.withOpacity(0.3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ListTile(
                                  title: Hero(tag: 'archive$counter',child: Text("${archives[counter].title}", style: AppBarText.page,)),
                                  subtitle: Text("${archives[counter].subtitle}", style: ListTileText.white,),
                                )
                              ],
                            ),
                          ),
                        ),
                    ),
                    Positioned.fill(
                      child: Material(
                        animationDuration: Duration(seconds: 2),
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => archives[counter].navTo));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
//              Transform.scale(
//              scale: curr == counter?1:0.9,
//              child: Card(
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                elevation: curr == counter?10.0:3.0,
//                semanticContainer: true,
//                clipBehavior: Clip.antiAliasWithSaveLayer,
//                child: Material(
//                  child: InkWell(
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => archives[counter].navTo));
//                    },
//                    splashColor: Colors.lightBlueAccent.withOpacity(0.3),
//                    child: Container(
//                      decoration: BoxDecoration(
//                        image: DecorationImage(image: AssetImage("${archives[counter].image}"), fit: BoxFit.cover),
//                      ),
//                      child: Container(
//                        color: Colors.transparent.withOpacity(0.3),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            ListTile(
//                              title: Text("${archives[counter].title}", style: allTabsAppBarText,),
//                              subtitle: Text("${archives[counter].subtitle}", style: ListTileDefaultTextStyle,),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            );
          }
      ),
    );
  }
}