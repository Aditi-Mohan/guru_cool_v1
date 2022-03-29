import 'package:cloud_firestore/cloud_firestore.dart';
import '/commons/user.dart';

class Word {
  String id;
  String word;
  String pronunciation;
  String meaning;
  List<String> sentence;

  Map<String, dynamic> get wordMap {
    Map<String, dynamic> obj = {
      "id": this.id,
      "word": this.word,
      "pronunciation": this.pronunciation,
      "meaning": this.meaning,
      "sentence": this.sentence,
    };
    return obj;
  }

  Word.fromMap(Map<String, dynamic> obj, String id) {
    this.id = id;
    this.word = obj["word"];
    this.pronunciation = obj["pronunciation"];
    this.meaning = obj["meaning"];
    List<String> r  = List<String>.from(obj["sentence"]);
    this.sentence = r;
  }
}

Future<List<Word>> getWords() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('Vocabulary').get();
  List<Word> words = [];
  qs.docs.forEach((element) {
    Word w = Word.fromMap(element.data(), element.id);
    words.add(w);
  });
  return words;
}

Future<List<Word>> getWordArchive(User obj) async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('users').doc('${obj.name}').collection('vocabulary').get();
  List<Word> words = [];
  qs.docs.forEach((element) {
    Word w = Word.fromMap(element.data(), element.id);
    words.add(w);
  });
  return words;
}

// TODO: RANDOM WORD SELECTOR => FOR QUIZZES