import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/collapsing_navigation_drawer.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'package:gurucoolv1/detail_pages/detail_page_vocabulary.dart';


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
                    if(snapshot.connectionState == ConnectionState.waiting ) {
                      return Center(child: Text("Loading..."));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            child: ListTile(
                              title: Text("${snapshot.data[index].documentID.toString().toUpperCase()}",style: CardTileText.heading,),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${snapshot.data[index].data['pronunciation']}", style: CardTileText.text),
                              ),
                              onTap: () => navigateToDetailPage(snapshot.data[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
      )
    );
  }
  
  Future getWords() async {
    var fire = Firestore.instance;
    QuerySnapshot qs = await fire.collection('Vocabulary').getDocuments();
    return qs.documents;
  }

  void navigateToDetailPage(DocumentSnapshot documentSnapshot) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageVocabulary(doc: documentSnapshot,)));
  }
}
