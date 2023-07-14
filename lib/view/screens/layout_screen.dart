import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:e_commerce/view/screens/shop_screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData4Shop()..getCategory4Shop()..getFavorites4Shop()..getCart4Shop()..getUserData4Shop(),
      child: BlocConsumer<ShopCubit , ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              title: Text('eShop',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.deepOrange,
                  fontStyle: FontStyle.italic,
                  fontFamily: GoogleFonts.aladin().fontFamily,
                ),
              ),
              actions:
              [
                IconButton(
                    style:const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0.0),
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
                    },
                    icon: const Icon(Icons.search , size: 30, color: Colors.orange,)),
                const SizedBox(width: 4,),
              ],
            ),
            body: cubit.screens[cubit.current],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.current,
              onTap: (value) => cubit.changeCurrentIndex(value),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.deepOrange,
              items: cubit.items,
            ),
          );
        },
      ),
    );
  }
}
