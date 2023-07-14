
class AddOrDeleteFavoriteModel
{
  late bool status ;
  late String message ;
  AddOrDeleteFavoriteModel.fromJson(Map<String , dynamic>json)
  {
    status = json['status'];
    message = json['message'];
  }

}