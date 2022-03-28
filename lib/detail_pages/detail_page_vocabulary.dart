import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/vocabulary_archive.dart';

class DetailPageVocabulary extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageVocabulary({this.doc});

  @override
  _DetailPageVocabularyState createState() => _DetailPageVocabularyState();
}

class _DetailPageVocabularyState extends State<DetailPageVocabulary> {

  final GlobalKey<ScaffoldState> _detailPageVocabulary = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      key: _detailPageVocabulary,
      appBar: AppBar(
        title: Text("${data['word'].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: VocabularyBackground,
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
                  color: VocabularyBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Pronunciation:\n ${data['pronunciation']}", style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
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
                      Text("Meaning: ${data['meaning']} \n\n\n Example: ${data['inasentence']}", style: DetailPageText.content,),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc('${obj.name}').collection('vocabulary').doc('${widget.doc.id}').set({'inasentence': data['inasentence'], 'pronunciation': data['pronunciation'], 'word': data['word'], 'meaning': data['meaning']});
            _detailPageVocabulary.currentState.showSnackBar(
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
                            child: Icon(Icons.thumb_up, color: VocabularyBackground, size: 20,),
                          ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Added to Archive", style: TextStyle(color: VocabularyBackground, fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),),
                      )
                        ],
                      ),
                      FlatButton(
                        child: Text("View Archive", style: TextStyle(color: VocabularyBackground),),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyArchive())),
                      )
                    ],
                  ),
                ),
              )
            );
          },
          label: Row(children: <Widget>[Icon(Icons.local_library, color: Colors.white,), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Learn\'t", style: AppBarText.page,),
          )],),
        backgroundColor: VocabularyBackground,
      )
    );
  }
}


class DetailPageVocabularyArchive extends StatefulWidget {

  final DocumentSnapshot doc;

  DetailPageVocabularyArchive({this.doc});

  @override
  _DetailPageVocabularyArchiveState createState() => _DetailPageVocabularyArchiveState();
}

class _DetailPageVocabularyArchiveState extends State<DetailPageVocabularyArchive> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.doc.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['word'].toString().toUpperCase()}", style: AppBarText.detailPage,),
        backgroundColor: VocabularyBackground,
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
                  color: VocabularyBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Pronunciation:\n ${data['pronunciation']}", style: DetailPageText.sidePanel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(thickness: 3.0, color: Colors.black38,),
                        ),
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
                      Text("Meaning: ${data['meaning']} \n\n\n Example: ${data['inasentence']}", style: DetailPageText.content,),
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
