import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/detail_pages/detail_page_vocabulary.dart';
import '/models/word.dart';
import '/commons/user.dart';


class Vocabulary extends StatefulWidget {

  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {

  List<Word> vocabulary = [];
  List<Word> archivedWords = [];
  Map<String, bool> arcMap;
  bool loaded = false;

  @override
  void initState() {
    getWords().then((words) {
      setState(() {
        vocabulary = words;
      });
      getWordArchive(obj).then((arcs) {
        setState(() {
          archivedWords = arcs;
        });
        Map<String, bool> map = wordIsInArchive(words, arcs);
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
//      backgroundColor: VocabularyBackgroundLight,
      appBar: AppBar(
        title: Text("VOCABULARY", style: AppBarText.page,),
        backgroundColor: VocabularyBackground,
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
                          itemCount: vocabulary.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: arcMap[vocabulary[index].id] ? VocabularyBackgroundLight : VocabularyBackground,
//                              elevation: 5.0,
                              child: ListTile(
                                title: Text(vocabulary[index].word.toUpperCase(),style: CardTileText.heading.copyWith(color: Colors.white),),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(vocabulary[index].pronunciation, style: CardTileText.text,),
                                ),
                                onTap: () => navigateToDetailPage(vocabulary[index], arcMap[vocabulary[index].id]),
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
//                FutureBuilder(
//                  future: getWords(),
//                  builder: (context, snapshot) {
//                    if(snapshot.connectionState == ConnectionState.done ) {
//                      return Expanded(
//                        child: ListView.builder(
//                          itemCount: snapshot.data.length,
//                          itemBuilder: (context, index) {
//                            QueryDocumentSnapshot word = snapshot.data[index];
//                            Map<String, dynamic> data = word.data();
//
//                            return Card(
//                              elevation: 5.0,
//                              child: ListTile(
//                                title: Text(
//                                  "${word.id.toString()
//                                      .toUpperCase()}",
//                                  style: CardTileText.heading,),
//                                subtitle: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Text("${data['pronunciation']}",
//                                      style: CardTileText.text),
//                                ),
//                                onTap: () =>
//                                    navigateToDetailPage(word),
//                              ),
//                            );
//                          },
//                        ),
//                      );
//                    }
//                    else {
//                      return Center(child: Text("Loading..."));
//                    }
//                  },
//                ),
              ],
            ),
      )
    );
  }

  Map<String, bool> wordIsInArchive(List<Word> words, List<Word> arcs) {
    Map<String, bool> res = {};
    words.forEach((element) {
      res[element.id] = false;
    });
    arcs.forEach((element) {
      res[element.id] = true;
    });
    return res;
  }

  void navigateToDetailPage(Word word, bool inArchive) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageVocabulary(word: word, inArchive: inArchive,)));
  }
}
