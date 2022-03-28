import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/detail_pages/detail_page_vocabulary.dart';


class Vocabulary extends StatefulWidget {

  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VocalbularyBackgroundLight,
      appBar: AppBar(
        title: Text("VOCABULARY", style: AppBarText.page,),
        backgroundColor: VocabularyBackground,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
        child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: getWords(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done ) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot word = snapshot.data[index];
                            Map<String, dynamic> data = word.data();

                            return Card(
                              elevation: 5.0,
                              child: ListTile(
                                title: Text(
                                  "${word.id.toString()
                                      .toUpperCase()}",
                                  style: CardTileText.heading,),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${data['pronunciation']}",
                                      style: CardTileText.text),
                                ),
                                onTap: () =>
                                    navigateToDetailPage(word),
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
              ],
            ),
      )
    );
  }
  
  Future getWords() async {
    var fire = FirebaseFirestore.instance;
    QuerySnapshot qs = await fire.collection('Vocabulary').get();
    return qs.docs;
  }

  void navigateToDetailPage(DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageVocabulary(doc: documentSnapshot,)));
  }
}
