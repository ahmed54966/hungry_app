class SideOptionsData {
    int? id;
    String? name;
    String? image;

    SideOptionsData({this.id, this.name, this.image});

    factory SideOptionsData.fromJson(Map<String, dynamic> json) {
      return SideOptionsData(
        id : json["id"],
        name : json["name"],
        image : json["image"],
      );

    }

}
