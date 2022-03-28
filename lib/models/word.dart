class Word {
  String id;
  String word;
  String pronunciation;
  String meaning;
  String sentence;

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

  Word.fromMap(Map<String, dynamic> obj) {
    this.id = obj["id"];
    this.word = obj["word"];
    this.pronunciation = obj["pronunciation"];
    this.meaning = obj["meaning"];
    this.sentence = obj["sentence"];
  }
}