class CategoryDataModel
{
  late bool status;
  late  AllCategoryData data;

  CategoryDataModel.fromJsom(Map<String,dynamic> json)
  {
    status = json['status'];
    data = AllCategoryData.fromJsom(json['data']);
  }

}

class AllCategoryData
{

  late int current_page;
  List<dynamic> data = [];

  AllCategoryData.fromJsom(Map<String,dynamic> json)
  {
    current_page = json['current_page'];
   json['data'].forEach((e)
   {
     data.add(e);
   });
  }

}

class CategoryData
{
  late int id;
  late String name;
  late String image;

  CategoryData.fromJsom(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }



}
