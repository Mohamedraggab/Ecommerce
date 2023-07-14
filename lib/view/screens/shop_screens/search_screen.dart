import 'package:flutter/material.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
          var searchController = TextEditingController();
          var searchProducts = cubit.modelSearch?.data.data;
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.deepOrange,
              backgroundColor: Colors.white,
              title: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Here',
                  border: InputBorder.none
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                  cubit.search(searchController.text);
                },
                  style:const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text('Search'),

                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: searchProducts != null,
              builder: (context) =>  state is !InitSearchShopState ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: searchProductS( searchProducts , context),
              ) : const Center(child: CircularProgressIndicator()),
              fallback: (context) => const Center(child: CircularProgressIndicator(),),
            ),

          ) ;
        },
      ),
    );
  }
}

searchProductS(var products , context)
{
  if(products.isNotEmpty) {
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
                            products[index].image.toString(),),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(products[index].name,
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
                            products[index].price.toString(),
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
                    Row(
                      children: [
                        Expanded(child: ElevatedButton(
                          onPressed: ()
                          {
                            ShopCubit.get(context).addOrDeleteToCart(products[index].id);
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
  else {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
      child: const Center(child: Text('No Items founded'),),
    );
  }
}