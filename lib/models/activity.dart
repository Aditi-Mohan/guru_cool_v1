class Activity {
  String id;
  String name;
  String description;
  String goal;
  String deets;

  Map<String, dynamic> get activityMap {
    Map<String, dynamic> obj = {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "goal": this.goal,
      "deets": this.deets,
    };
    return obj;
  }

  Activity.fromMap(Map<String, dynamic> obj) {
        this.id = obj["id"];
        this.name = obj["name"];
        this.description = obj["description"];
        this.goal = obj["goal"];
        this.deets = obj["deets"];
  }
}