import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:e_commerce/core/model/addToCart.dart';
import 'package:e_commerce/core/model/add_delete_fav.dart';
import 'package:e_commerce/core/model/category_data_model.dart';
import 'package:e_commerce/core/model/home_data_model.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/view/screens/shop_screens/category_screen.dart';
import 'package:e_commerce/view/screens/shop_screens/fav_screen.dart';
import 'package:e_commerce/view/screens/shop_screens/home_screen.dart';
import 'package:e_commerce/view/screens/shop_screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/model/favorites_model.dart';

import '../../model/get_cart_items_model.dart';
import '../../model/get_profile_model.dart';
import '../../model/search_model.dart';

class ShopCubit extends Cubit<ShopState>
{
  ShopCubit() : super(InitShopState());

  static ShopCubit get(context) => BlocProvider.of(context);


  ////////////////////Layout///////////////////

  List<BottomNavigationBarItem>  items = const [
  BottomNavigationBarItem(icon: Icon(Icons.home) , label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.apps_sharp) , label: 'Category'),
  BottomNavigationBarItem(icon: Icon(Icons.favorite) , label: 'Favorites'),
  BottomNavigationBarItem(icon: Icon(Icons.settings) , label: 'Settings'),
  ] ;


  int current = 0 ;
  changeCurrentIndex(int index)
  {
    current = index ;

    emit(ChangeIndex());
  }

  var screens = const [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  HomeModel? model ;
  List<String> bans = [] ;
  List<dynamic> products = [] ;

  Map<int,bool> favorites = {};

  getHomeData4Shop()
  {
    emit(InitGetDataShopState());
    DioHelper4Shop.getData(
        token: ShopConsts.token.toString(),
        url: 'home'
    )
        .then((value){
          model = HomeModel.fromJson(value.data);
          model!.data.banners.forEach((element){
            bans.add(element['image'].toString());
          });
          model!.data.products.forEach((element){
            favorites.addAll({element['id']: element['in_favorites']});
          });
          products = model!.data.products;
          emit(SuccessGetDataShopState());
    })
        .catchError((error){
          emit(ErrorGetDataShopState());
          print(error.toString());
    });
  }



  CategoryDataModel?  categoryModel ;

  getCategory4Shop()
  {
    emit(InitGetCategoryShopState());
    DioHelper4Shop.getData(
        token: ShopConsts.token.toString(),
        url: 'categories'
    )
        .then((value){
      categoryModel = CategoryDataModel.fromJsom(value.data);
      emit(SuccessGetCategoryShopState());
    })
        .catchError((error){
      emit(ErrorGetCategoryShopState());
      print(error.toString());
    });
  }


  AddOrDeleteFavoriteModel? favModel ;

  addOrDeleteFav(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(InitGetFavoritesShopState());
    DioHelper4Shop.postData(
        token: ShopConsts.token.toString(),
        url: 'favorites',
        data: { "product_id": productId })
        .then((value){
          getFavorites4Shop();
          favModel = AddOrDeleteFavoriteModel.fromJson(value.data);
          if(!favModel!.status) {
            favorites[productId] = !favorites[productId]!;
          }
          emit(SuccessGetFavoritesShopState());
    })
        .catchError((error){
          emit(ErrorGetFavoritesShopState());
          favorites[productId] = !favorites[productId]!;
          print(error.toString());
    });
  }

  FavoritesModel? modelOfFavoritesItem ;

  getFavorites4Shop()
  {
    emit(InitGetFavoritesProductShopState());
    DioHelper4Shop.getData(
        token: ShopConsts.token.toString(),
        url: 'favorites'
    )
        .then((value){
      modelOfFavoritesItem = FavoritesModel.fromJson(value.data);
      emit(SuccessGetFavoritesProductShopState());
    })
        .catchError((error){
      emit(ErrorGetFavoritesProductShopState());
      print(error.toString());
    });
  }

  ToCart? cartModel ;

  addOrDeleteToCart(int productId)
  {
    emit(InitAddCartShopState());
    DioHelper4Shop.postData(
        token: ShopConsts.token.toString(),
        url: 'carts',
        data: { "product_id": productId })
        .then((value){
      getFavorites4Shop();
      cartModel = ToCart.fromJson(value.data);
      print(value.data);
      emit(SuccessAddCartShopState());
    })
        .catchError((error){
      emit(ErrorAddCartShopState());
      print(error.toString());
    });
  }


  GetCartItems? getCart ;
  getCart4Shop()
  {
    emit(InitGetCartShopState());
    DioHelper4Shop.getData(
        token: ShopConsts.token.toString(),
        url: 'carts'
    )
        .then((value){
      getCart = GetCartItems.fromJson(value.data);
      print(value.data);
      emit(SuccessGetCartShopState());
    })
        .catchError((error){
      emit(ErrorGetCartShopState());
      print(error.toString());
    });
  }


  SearchModel? modelSearch;
  search(String searchWord)
  {
    emit(InitSearchShopState());
    DioHelper4Shop.postData(
        token: ShopConsts.token.toString(),
        url: 'products/search',
        data: { "text": searchWord })
        .then((value){
      modelSearch = SearchModel.fromJson(value.data);
      emit(SuccessSearchShopState());
    })
        .catchError((error){
      emit(ErrorSearchShopState());
      print(error.toString());
    });
  }



  GetProfileModel? getDataModel ;

  getUserData4Shop()
  {
    emit(InitGetUserDataShopState());
    DioHelper4Shop.getData(
        token: ShopConsts.token.toString(),
        url: 'profile'
    )
        .then((value){
      print('77777777777777777777777777777777777777777777777777777777777777777777777777777777');
      print(value.data);
      getDataModel = GetProfileModel.fromJson(value.data);
      print(getDataModel!.data);
      emit(SuccessGetUserDataShopState());
    })
        .catchError((error){
      emit(ErrorGetUserDataShopState());
      print(error.toString());
    });
  }


}