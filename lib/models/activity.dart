import 'package:cloud_firestore/cloud_firestore.dart';
import '/commons/user.dart';

class Activity {
  String id;
  String name;
  String description;
  String goal;
  String deets;

  Map<String, dynamic> get activityMap {
    Map<String, dynamic> act = {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "goal": this.goal,
      "deets": this.deets,
    };
    return act;
  }

  Activity.fromMap(Map<String, dynamic> obj, String id) {
        this.id = id;
        this.name = obj["name"];
        this.description = obj["description"];
        this.goal = obj["goal"];
        this.deets = obj["deets"];
  }
}

Future<List<Activity>> getActivities() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('Activities').get();
  List<Activity> activities = [];
  qs.docs.forEach((element) {
    Activity a = Activity.fromMap(element.data(), element.id);
    activities.add(a);
  });
  return activities;
}

Future<List<Activity>> getActivityArchive(User obj) async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('users').doc('${obj.name}').collection('activities').get();
  List<Activity> activities = [];
  qs.docs.forEach((element) {
    Activity a = Activity.fromMap(element.data(), element.id);
    activities.add(a);
  });
  return activities;
}

Future<Activity> getTodaysActivity() async {
  var fire = FirebaseFirestore.instance;
  QuerySnapshot qs = await fire.collection('Today\'sActivity').get();
  Activity a = Activity.fromMap(qs.docs[0].data(), qs.docs[0].id);
  return a;
}