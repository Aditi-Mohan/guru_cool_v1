import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/detail_pages/detail_page_vocabulary.dart';
import '/models/word.dart';

class VocabularyArchive extends StatefulWidget {

  @override
  _VocabularyArchiveState createState() => _VocabularyArchiveState();
}

class _VocabularyArchiveState extends State<VocabularyArchive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VocabularyBackgroundLight,
      appBar: AppBar(
        title: Text("VOCABULARY ARCHIVE", style: AppBarText.page,),
        backgroundColor: VocabularyBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Word>>(
              future: getWordArchive(obj),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: Text("Loading..."),
                  );
                else if(snapshot.data.length == 0)
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("You haven\'t learn\'t any Words yet!", style: TextStyle(color: selectedColor, fontWeight: FontWeight.w900, fontSize: 30.0)),
                  ));
                else {
                  List<Word> words = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(words[index].word.toString().toUpperCase(), style: CardTileText.heading,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(words[index].pronunciation,
                                  style: CardTileText.text,),
                              ],
                            ),
                            onTap: () =>
                                navigateToDetailPage(words[index]),
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

  void navigateToDetailPage(Word word) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageVocabulary(word: word, inArchive: true,)));
  }

}
