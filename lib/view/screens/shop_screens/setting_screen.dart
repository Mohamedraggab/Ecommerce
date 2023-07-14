import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/core/controller/shop_cubit/shop_cubit.dart';
import 'package:e_commerce/core/shared_preference/shared_preference.dart';
import 'package:e_commerce/view/screens/auth_screens/login.dart';
import 'package:e_commerce/view/widgets/custom_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controller/shop_cubit/shop_states.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var cubit = ShopCubit.get(context);
        var model = cubit.getDataModel!.data;
        nameController.text = model.name;
        emailController.text = model.email;
        phoneController.text = model.phone;
        return Scaffold(
          body: ConditionalBuilder(
            condition: true,
            builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextFormField(controller: nameController, label: 'Name', borderType:const  OutlineInputBorder() ,prefix: const Icon(Icons.person)),
                customTextFormField(controller: emailController, label: 'Email', borderType:const  OutlineInputBorder() , prefix:const Icon(Icons.mail_outline)),
                customTextFormField(controller: phoneController, label: 'Phone', borderType:const  OutlineInputBorder() , prefix: const Icon(Icons.phone)),

              ],
            ), fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                CacheHelper.removeData(key: 'token');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => true);
              } ,
              child: const Icon(Icons.logout)),
        );
      },
    );
  }
}
