class ToCart {
  late bool status;
  late String message;
  late Data data;


  ToCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  late int id;
  late int quantity;
  late Product product;


  Data.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     quantity = json['quantity'];
     product = Product.fromJson(json['product']);
  }

}

class Product {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
