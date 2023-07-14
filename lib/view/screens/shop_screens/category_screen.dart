import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var category = cubit.categoryModel?.data.data;
        return ConditionalBuilder(
          condition: category != null,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        margin:const EdgeInsets.all(5),
                        width: 130,
                        height: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(category[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(category[index]['name'],style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepOrange,
                        overflow: TextOverflow.ellipsis,
                      ),
                        softWrap: true,
                      ),
                      const Spacer(),
                      IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios_outlined , color: Colors.deepOrange,)),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: category!.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

