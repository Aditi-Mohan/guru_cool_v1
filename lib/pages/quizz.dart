import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gurucoolv1/pages/quizz_finish_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '/commons/user.dart';
import '/models/word.dart';
import '/commons/theme.dart';

class Question {
  final String q;
  final String ans;
  final bool isMeaning;

  Question({this.q, this.ans, this.isMeaning});
}

class Quizz extends StatefulWidget {
  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {

//  Future<List<Word>> words;
  Future<List<Question>> questions;
  int score = 0;
  int answered = 0;
  int numOfQuestions = 10;
  TextEditingController _answer = new TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    questions = getRandomQuestion(numOfQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HomepageBackground,
        title: Text("Test Your Vocabulary", style: AppBarText.page,),
        elevation: 0,
      ),
      body: FutureBuilder<List<Question>>(
        future: questions,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            List<Question> qs = snapshot.data;
            numOfQuestions = qs.length;
            print(numOfQuestions);
            return Container(
              width: MediaQuery.of(context).size.width,
//              color: Colors.black54,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 100,
                    percent: answered/numOfQuestions,
                    progressColor:Color.fromRGBO(181,217,157, 1),
                    padding: EdgeInsets.zero,
                    backgroundColor: Color.fromRGBO(208,210,212, 0.5),
//                    barRadius: Radius.circular(10),
                  ),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              qs[answered].isMeaning ? "Which word can be defined as: " : "Fill in the Blank: ",
                              style: CardTileText.questionTile.copyWith(color: HomepageBackground),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(qs[answered].q, style: ListTileText.black.copyWith(color: Colors.black54), textAlign: TextAlign.center,),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: 1,
                                controller: _answer,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  errorText: _validate
                                      ? "Answer cannot be empty"
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    color: HomepageBackground,
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: <Widget>[
                          Text(answered < numOfQuestions-1 ? "Next" : "Finish",
                            style: ListTileText.white.copyWith(color: Colors.white),),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if(_answer.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      }
                      else {
                        if(_answer.text.toLowerCase() == qs[answered].ans) {
                          score+=1;
                        }
                        if(answered < numOfQuestions-1) {
                          _answer.text = "";
                          setState(() {
                            _validate = false;
                            answered += 1;
                          });
                        }
                        else {
                          print("Finished $score");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizzFinish(score: score, total: numOfQuestions,)));
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          }
          else return CircularProgressIndicator();
        },
      ),
    );
  }
}

Future<List<Question>> getRandomQuestion(int size) async {
  List<Word> ws = await getWordArchive(obj);
  List<Question> q1 = makeMeaningQuestion(ws);
  List<Question> q2 = makeSentenceQuestion(ws);
  List<Question> qs = q1 + q2;
  qs.shuffle();
  qs.forEach((element) {
    print(element.q);
    print(element.ans);
  });
  return qs.sublist(0, min(qs.length, size));
}

List<Question> makeMeaningQuestion(List<Word> words) {
  List<Question> qs = [];
  words.forEach((element) {
    Question q = Question(q: element.meaning.toLowerCase(), ans: element.word.toLowerCase(), isMeaning: true);
    qs.add(q);
  });
  return qs;
}

List<Question> makeSentenceQuestion(List<Word> words) {
  List<Question> qs = [];
  words.forEach((element) {
    element.sentence.forEach((ele) {
      Question q = Question(q: ele.toLowerCase().replaceAll(element.word.toLowerCase(), "_______"), ans: element.word.toLowerCase(), isMeaning: false);
      qs.add(q);
    });
  });
  return qs;
}
