import 'package:flutter/material.dart';
import '/pages/activity_archive.dart';
import '/pages/recipe_archive.dart';
import '/pages/vocabulary_archive.dart';

class NavBarElements {
  String title;
  IconData icon;

  NavBarElements({this.title, this.icon});
}

class ArchiveElements {
  String title;
  String subtitle;
  Widget navTo;
  String image;

  ArchiveElements({this.title, this.subtitle, this.image, this.navTo});
}

List<NavBarElements> list = [
  NavBarElements(title: "Home", icon: Icons.home),
  NavBarElements(title:"Activities", icon: Icons.list),
  NavBarElements(title:"Recipes", icon: Icons.fastfood),
  NavBarElements(title:"Reminders", icon: Icons.alarm),
  NavBarElements(title: "Vocalbulary", icon: Icons.collections_bookmark),
  NavBarElements(title: "About Us", icon: Icons.help_outline)
];

List<ArchiveElements> archives = [
  ArchiveElements(title: "Recipes", subtitle: "Checkout the Recipes you previously tried", image: "assets/food5.jpg", navTo: RecipeArchive()),
  ArchiveElements(title: "Activities", subtitle: "Checkout the Activties you previously enjoyed", image: "assets/activity.png", navTo: ActivityArchive()),
  ArchiveElements(title: "Vocabulary", subtitle: "Checkout the Words you previously learn't", image: "assets/vocab.png", navTo: VocabularyArchive())
];