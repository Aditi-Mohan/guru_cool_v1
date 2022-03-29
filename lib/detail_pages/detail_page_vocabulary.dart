import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/pages/vocabulary.dart';
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
    Widget body = Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
//              height: 111,
              width: MediaQuery.of(context).size.width,
              color: VocabularyBackgroundLight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(widget.word.word.toUpperCase(), style: CardTileText.heading, textAlign: TextAlign.center,),
                  ),
                  Container(height: 10,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: ListTile(
                leading: Icon(
                  Icons.record_voice_over,
                  color: VocabularyBackgroundLight,
                ),
                title: Text(widget.word.pronunciation, style: CardTileText.text,),
              ),
            ),
//            Card(
//              semanticContainer: true,
//              clipBehavior: Clip.antiAliasWithSaveLayer,
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//              child: ,
//            ),
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
//                          color: Color.fromRGBO(245,144,139, 1),
                          color: VocabularyBackgroundLight,
                          image: DecorationImage(image: AssetImage("assets/books.png"), fit: BoxFit.contain, alignment: Alignment.topLeft)
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
                            widget.word.meaning, style: DetailPageText.sidePanel.copyWith(color: Colors.white),
//                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
//                  color: RecipeBackgroundLight.withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Text(
                              "Examples",
                              style: CardTileText.questionTile.copyWith(fontSize: 20, color: VocabularyBackground,
//                              shadows: [Shadow(offset: Offset(0.0, 1), blurRadius: 5, color: Colors.white,),]
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 4.0, bottom: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width-20,
                              child: Text(
                                "Differnet examples will use different Forms of the word like - Past Tense, Singular, Plural...",
                                style: CardTileText.text.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height-380,
                    width: MediaQuery.of(context).size.width,
//                    color: VocabularyBackground,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.word.sentence.length+1,
                      itemBuilder: (context, index) {
                        if(index == widget.word.sentence.length)
                          return Container(height: 85,);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            elevation: 1,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: VocabularyBackground, width: 10),
                                    right: BorderSide(color: VocabularyBackgroundLight, width: 2),
                                    top: BorderSide(color: VocabularyBackgroundLight, width: 2),
                                    bottom: BorderSide(color: VocabularyBackgroundLight, width: 2)
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  title: Text(widget.word.sentence[index], style: CardTileText.text,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//              child: Card(
//                  child: Container(
//                    width: MediaQuery.of(context).size.width-20,
//                    height: 100,
//                    child: Center(child: Text(widget.word.meaning, style: CardTileText.text,))
//                  )
//              ),
//            ),
          ],
        ),
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
    return body;
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
