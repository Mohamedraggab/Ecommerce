import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants.dart';
class DioHelper
{
  static Dio? dio ;


  static initDio()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: GetConst.baseUri,
          receiveDataWhenStatusError: true ,
          headers: {
            "Content-Type":"application/json",

          }
        ),
    );
  }

  static Future<Response> postData({
    required String url ,
    required Map<String , dynamic> query
  })async
  {
    return await dio!.post(url ,data: query);
  }


}







class DioHelper4Shop
{
  static Dio? dio ;


  static initDio()
  {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true ,
      ),
    );
  }



  static Future<Response> getData(
  {
    required String token ,
    required String url ,
}
      )async
  {
    dio!.options.headers = {
      'lang':'en',
      "Content-Type":"application/json",
      'Authorization':token,
    };
    return await dio!.get(url);
  }




  static Future<Response> postData({
    required String token ,
    required String url ,
    required Map<String , dynamic> data ,
  })async
  {
    dio!.options.headers = {
      'lang':'en',
      'Authorization':token,
    };
    return await dio!.post(url ,data: data);
  }


  static Future<Response> postData4Login({
    required String url ,
    required Map<String , dynamic> data ,
  })async
  {
    dio!.options.headers = {
      'lang':'en',
    };
    return await dio!.post(url ,data: data);
  }

}