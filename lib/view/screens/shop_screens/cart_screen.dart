import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
        child: BlocConsumer<ShopCubit , ShopState>
          (
          listener: (context, state) {

          },
          builder: (context, state) {
            var cubit = ShopCubit.get(context);
            var cartProducts = cubit.getCart?.data.cartItems;
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: ConditionalBuilder(
                condition: cartProducts != null,
                builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: cartProductS(cartProducts , context),
                ),
                fallback: (context) => const Center(child: Text('No items'),),
              ),

            ) ;
          },
        ),
    );
  }
}



cartProductS(var products , context)
{
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            children: List.generate(products.length, (index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              products[index].product.image.toString(),),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(products[index].product.name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          maxLines: 2),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                              products[index].product.price.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue),
                              maxLines: 2),
                          const SizedBox(
                            width: 15,
                          ),
                          ///////////////////////////
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );

  }