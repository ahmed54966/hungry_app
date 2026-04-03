class AuthModel {
    String? token;
    String name;
    String email;
    String? image;
    String? visa;
    String? address;

    AuthModel({this.token,required this.name,required this.email, this.image,this.address,this.visa });

    factory AuthModel.fromJson(Map<String, dynamic> json) {
      return AuthModel(
        token : json["token"],
        name : json["name"],
        email : json["email"],
        image : json["image"],
        visa : json["Visa"],
        address : json["address"]
        );
        
    }

}
