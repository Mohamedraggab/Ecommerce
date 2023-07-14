class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  late int currentPage;
  late List<Product> data;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      data =  <Product>[];
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });

  }

}

class Product {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
