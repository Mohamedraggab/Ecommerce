import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.model != null && cubit.categoryModel != null ,
            builder: (context) => SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  slider(cubit.bans, context),
                  const SizedBox(height: 10),
                  categoryBuilder(cubit.categoryModel!.data.data),
                  newProduct(cubit.products , context),
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

slider(List<String> links, context) {
  return CarouselSlider(
    items: links
        .map((item) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item),
                  fit: BoxFit.cover,
                ),
              ),
            ))
        .toList(),
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.28,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),
  );
}

newProduct(var products , context)
{
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('New Products',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w700)),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.9,
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
                                  products[index]['image']),
                            ),
                          ),
                        ),
                        if (products[index]['discount'] != 0)
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
                    Text(products[index]['name'],
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
                            products[index]['price'].toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue),
                            maxLines: 2),
                        const SizedBox(
                          width: 10,
                        ),
                        if (products[index]['discount'] != 0)
                          Text(
                              products[index]['old_price']
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  decoration: TextDecoration
                                      .lineThrough),
                              maxLines: 2),
                        ///////////////////////////
                        const Spacer(),
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: ShopCubit.get(context).favorites[products[index]['id']]! ? Colors.deepOrange : Colors.grey,
                          child: IconButton(
                            onPressed: (){
                              ShopCubit.get(context).addOrDeleteFav(products[index]['id']);
                            }, icon: const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 17, ),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: ElevatedButton(
                            onPressed: ()
                            {
                              ShopCubit.get(context).addOrDeleteToCart(products[index]['id']);
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



categoryBuilder(List<dynamic> cat)
{
  return Padding(
    padding: const EdgeInsets.only(left: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category',style: TextStyle(
        fontSize: 20,
        color: Colors.deepOrange,
        fontWeight: FontWeight.w700)),
        const SizedBox(height: 10,),
        Container(
          decoration: const BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(15)),
          ),
          height: 150,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 140,
                    height: 150,
                    decoration:BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: NetworkImage(cat[index]['image']),
                          fit: BoxFit.cover
                        ),
                    ) ,),
                  Container(
                    width: 140,
                    height: 20,
                    decoration:const BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: Center(child: Text(cat[index]['name'] , style: const TextStyle(color: Colors.black , fontSize: 14 , fontWeight: FontWeight.w600))),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10,),
              itemCount: cat.length),
        ),
      ],
    ),
  );
}