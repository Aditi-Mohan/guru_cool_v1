import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/models/word.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/pages/vocabulary_archive.dart';

class DetailPageVocabulary extends StatefulWidget {

  final Word word;
  final bool inArchive;

  DetailPageVocabulary({this.word, this.inArchive});

  @override
  _DetailPageVocabularyState createState() => _DetailPageVocabularyState();
}

class _DetailPageVocabularyState extends State<DetailPageVocabulary> {

  final GlobalKey<ScaffoldState> _detailPageVocabulary = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _detailPageVocabulary,
      appBar: AppBar(
        title: Text(widget.word.word.toString().toUpperCase(), style: AppBarText.detailPage,),
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
                        Text("Pronunciation:\n ${widget.word.pronunciation}", style: DetailPageText.sidePanel,),
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
                      Text("Meaning: ${widget.word.meaning} \n\n\n Example: ${widget.word.sentence}", style: DetailPageText.content,),
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
                .collection('vocabulary').doc('${widget.word.id}').set(
                {
                  'inasentence': widget.word.sentence,
                  'pronunciation': widget.word.pronunciation,
                  'word': widget.word.word,
                  'meaning': widget.word.meaning
                });
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
          label: Row(
            children: [
              !widget.inArchive ? Icon(Icons.local_library, color: Colors.white,) : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    if(widget.inArchive) return Text("Completed", style: AppBarText.page,);
                    return Text("Complete", style: AppBarText.page,);
                  }
                ),
              )
            ],
          ),
        backgroundColor: widget.inArchive ? VocabularyBackgroundLight : VocabularyBackground,
      )
    );
  }
}
