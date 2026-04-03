class ToppingModel {
    int? id;
    String? name;
    String? image;

    ToppingModel({this.id, this.name, this.image});

    factory ToppingModel.fromJson(Map<String, dynamic> json) {
      return ToppingModel(
        id : json["id"],
        name : json["name"],
        image : json["image"],
      );
        
    }

}
