class CartModel {
    int? productId;
    int? quantity;
    double? spicy;
    List<int>? toppings;
    List<int>? sideOptions;

    CartModel({this.productId, this.quantity, this.spicy, this.toppings, this.sideOptions});

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["product_id"] = productId;
        _data["quantity"] = quantity;
        _data["spicy"] = spicy;
        if(toppings != null) {
            _data["toppings"] = toppings;
        }
        if(sideOptions != null) {
            _data["side_options"] = sideOptions;
        }
        return _data;
    }
}

class CartRequestModel{
  final List<CartModel> items;
  CartRequestModel({required this.items});
  Map<String, dynamic> toJson() =>{
  "items":items.map((e)=>e.toJson()).toList()
  };
}



class CartResponseModel {
    int? code;
    String? message;
    Data? data;

    CartResponseModel({this.code, this.message, this.data});

    CartResponseModel.fromJson(Map<String, dynamic> json) {
        code = json["code"];
        message = json["message"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["code"] = code;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    int? id;
    String? totalPrice;
    List<Items>? items;

    Data({this.id, this.totalPrice, this.items});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        totalPrice = json["total_price"];
        items = json["items"] == null ? null : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["total_price"] = totalPrice;
        if(items != null) {
            _data["items"] = items?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Items {
    int? itemId;
    int? productId;
    String? name;
    String? image;
    int? quantity;
    String? price;
    String? spicy;
    List<Toppings>? toppings;
    List<SideOptions>? sideOptions;

    Items({this.itemId, this.productId, this.name, this.image, this.quantity, this.price, this.spicy, this.toppings, this.sideOptions});

    Items.fromJson(Map<String, dynamic> json) {
        itemId = json["item_id"];
        productId = json["product_id"];
        name = json["name"];
        image = json["image"];
        quantity = json["quantity"];
        price = json["price"];
        spicy = json["spicy"];
        toppings = json["toppings"] == null ? null : (json["toppings"] as List).map((e) => Toppings.fromJson(e)).toList();
        sideOptions = json["side_options"] == null ? null : (json["side_options"] as List).map((e) => SideOptions.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["item_id"] = itemId;
        _data["product_id"] = productId;
        _data["name"] = name;
        _data["image"] = image;
        _data["quantity"] = quantity;
        _data["price"] = price;
        _data["spicy"] = spicy;
        if(toppings != null) {
            _data["toppings"] = toppings?.map((e) => e.toJson()).toList();
        }
        if(sideOptions != null) {
            _data["side_options"] = sideOptions?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class SideOptions {
    int? id;
    String? name;
    String? image;

    SideOptions({this.id, this.name, this.image});

    SideOptions.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["image"] = image;
        return _data;
    }
}

class Toppings {
    int? id;
    String? name;
    String? image;

    Toppings({this.id, this.name, this.image});

    Toppings.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["image"] = image;
        return _data;
    }
}

