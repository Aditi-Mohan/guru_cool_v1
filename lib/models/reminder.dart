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

  Reminder.fromMap(Map<String, dynamic> obj) {
    this.id = obj["id"];
    this.title = obj["title"];
    this.description = obj["description"];
  }
}