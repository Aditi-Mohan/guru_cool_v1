class Recipe {
  String id;
  String name;
  String prepTime;
  String level;
  String recp;

  Map<String, dynamic> get recipeMap {
    Map<String, dynamic> obj = {
      "id": this.id,
      "name": this.name,
      "prepTime": this.prepTime,
      "level": this.level,
      "recp": this.recp,
    };
    return obj;
  }

  Recipe.fromMap(Map<String, dynamic> obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.prepTime = obj["prepTime"];
    this.level = obj["level"];
    this.recp = obj["recp"];
  }
}