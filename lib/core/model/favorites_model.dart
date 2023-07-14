class FavoritesModel
{
  late bool status;
  late Data data;
  FavoritesModel.fromJson(Map<String , dynamic>json)
  {
    status = json['status'];
    data= Data.fromJson(json['data']);
  }


}

class Data
{
  late int currentPage;
  List<DataItem> data = [] ;

  Data.fromJson(Map<String , dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((e){
      data.add(DataItem.fromJson(e));
    });
  }


}

class DataItem
{
  late int idInFavorites;
  late FavoriteProductData product ;
  DataItem.fromJson(Map<String , dynamic>json)
  {
    idInFavorites = json['id'];
    product= FavoriteProductData.fromJson(json['product']);
  }
}

class FavoriteProductData
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late int discount;
  late String image;
  late String name;
  FavoriteProductData.fromJson(Map<String , dynamic>json)
  {
    id = json['id'];
    price= json['price'];
    old_price= json['old_price'];
    discount= json['discount'];
    image= json['image'];
    name= json['name'];
  }
}