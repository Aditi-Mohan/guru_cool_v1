import 'package:cloud_firestore/cloud_firestore.dart';
import '/commons/user.dart';

class Reminder {
  String id;
  String title;
  String description;

  Map<String, dynamic> get reminderMap {
    Map<String, dynamic> obj = {
      "id": this.id,
      "title": this.title,
      "description": this.description,
    };
    return obj;
  }

  Reminder.fromMap(Map<String, dynamic> obj, String id) {
    this.id = id;
    this.title = obj["title"];
    this.description = obj["description"];
  }
}

Future<List<Reminder>> getReminders() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('Reminders').get();
  List<Reminder> rems = [];
  qs.docs.forEach((element) {
    Reminder r = Reminder.fromMap(element.data(), element.id);
    rems.add(r);
  });
  return rems;
}