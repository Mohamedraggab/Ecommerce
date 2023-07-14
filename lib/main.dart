import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/controller/observer.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:e_commerce/view/screens/auth_screens/login.dart';
import 'package:e_commerce/view/screens/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/shared_preference/shared_preference.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver() ;
  DioHelper4Shop.initDio();
  DioHelper.initDio();
  await CacheHelper.init();
  runApp(const MyApp());
}

Widget? startWidget ;



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ShopConsts.token =CacheHelper.getData(key: 'token');
    if(ShopConsts.token == null)
    {
      startWidget = const LoginScreen();
    }
    else
    {
      startWidget =const LayoutScreen();
    }
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().fontFamily),
      home: startWidget,
    );
  }
}
