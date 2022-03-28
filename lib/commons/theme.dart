import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TextStyle ListTileDefaultTextStyle = TextStyle(color: Colors.white70, fontSize: 15.0, fontWeight: FontWeight.w600);
//TextStyle ListTileDefaultTextStyle2 = TextStyle(color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w600);
//TextStyle ListTileSelectedTextStyle = TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w600);
//
//TextStyle detailPageContent = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontWeight: FontWeight.w600);
//TextStyle detailPageContentSidePanel = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);
//
//TextStyle cardTileHeading = TextStyle(color: Color.fromRGBO(84, 80, 83, 1), fontSize: 18.0, fontWeight: FontWeight.w900);
//TextStyle cardTileText = TextStyle(color: Color.fromRGBO(84, 80, 83, 1), fontSize:15.0,);
//TextStyle homePageQuestionText = TextStyle(color: Colors.black54, fontWeight: FontWeight.w900, fontSize: 20.0);
//
//TextStyle allTabsAppBarText = TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0);
//TextStyle allDetailPageAppBarText = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontWeight: FontWeight.w900);
//
//TextStyle snackBarText = TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 20.0);

Color defColor = Colors.white70;
Color drawerBackgroundColor = Color.fromRGBO(66, 177, 237, 1);
Color drawerBackgroundLight = Color.fromRGBO(135, 214, 230, 1);
Color cardTileDefaultColor = Color.fromRGBO(255, 252, 168, 1);
Color selectedColor = Color.fromRGBO(50, 64, 54, 1);
Color RecipeBackground = Color.fromRGBO(255, 185, 20, 1);
Color RecipeBackgroundLight = Color.fromRGBO(247, 220, 136, 1);
Color ActivityBackgroundLight = Color.fromRGBO(255, 189, 145, 1);
Color ActivityBackground = Color.fromRGBO(247, 150, 59, 1);
Color ReminderBackground = Color.fromRGBO(245, 59, 59, 1);
Color ReminderBackgroundLight = Color.fromRGBO(255, 125, 125, 1);
Color HomepageBackground = drawerBackgroundColor;
Color HomepageBackgroundLight = Color.fromRGBO(135, 214, 230, 1);
Color VocabularyBackground = Color.fromRGBO(105, 207, 68, 1);
Color VocabularyBackgroundLight = Color.fromRGBO(157, 227, 154, 1);

class ListTileText {
  static const TextStyle white = TextStyle(color: Colors.white70, fontSize: 15.0, fontWeight: FontWeight.w600);
  static const TextStyle black = TextStyle(color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.w600);
  static const TextStyle blue = TextStyle(color: Color.fromRGBO(66, 177, 237, 1), fontSize: 15.0, fontWeight: FontWeight.w600);
  static const TextStyle selected = TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w600);
}

class CardTileText {
  static const TextStyle heading = TextStyle(color: Color.fromRGBO(84, 80, 83, 1), fontSize: 18.0, fontWeight: FontWeight.w900);
  static const TextStyle text = TextStyle(color: Color.fromRGBO(84, 80, 83, 1), fontSize:15.0,);
  static const TextStyle questionTile = TextStyle(color: Colors.black54, fontWeight: FontWeight.w900, fontSize: 20.0);
}

class AppBarText {
  static const TextStyle page = TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.0);
  static const TextStyle detailPage = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontWeight: FontWeight.w900);
}

class DetailPageText {
  static const TextStyle content = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle sidePanel = TextStyle(color: Color.fromRGBO(50, 64, 54, 1), fontSize: 18, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic);
}