import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var favProducts = cubit.modelOfFavoritesItem?.data.data;
        return ConditionalBuilder(
            condition: favProducts != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: favoriteProductS( favProducts , context),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}


favoriteProductS(var products , context)
{
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('Favorites',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w700)),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.7,
          children: List.generate(products.length, (index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
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
                        if (products[index].product.discount != 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                            color: Colors.red,
                            child: const Text('Discount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12)),
                          ),
                      ],
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
                        if (products[index].product.discount != 0)
                          Text(
                              products[index].product.old_price
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  decoration: TextDecoration
                                      .lineThrough),
                              maxLines: 2),
                        ///////////////////////////
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: ElevatedButton(
                          onPressed: ()
                          {
                            ShopCubit.get(context).addOrDeleteToCart(products[index].product.id);
                          },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepOrange)),
                          child: const Text('Add To Cart' ,style: TextStyle(fontWeight: FontWeight.w600)),
                        )),
                      ],
                    ), ///AddCart
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