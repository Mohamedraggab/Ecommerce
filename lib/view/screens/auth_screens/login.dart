import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/controller/auth_controller/auth_cubit.dart';
import 'package:e_commerce/core/controller/auth_controller/auth_states.dart';
import 'package:e_commerce/core/shared_preference/shared_preference.dart';
import 'package:e_commerce/view/screens/auth_screens/register.dart';
import 'package:e_commerce/view/screens/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit , AuthState>
        (
        listener: (context, state) {

          if(state is  SuccessLoginState)
          {
            ShopConsts.token = CacheHelper.getData(key: 'token');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const  LayoutScreen(),), (route) => true);
          }

        },
        builder: (context, state) {
          var userController = TextEditingController();
          var passController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding:const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 250,
                        child: Center(
                            child: Text('Sign In', style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w700 , color: Colors.blue),)),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: userController ,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if(userController.text.isEmpty)
                                {
                                  return 'Invalid';
                                }
                                else
                                {
                                  return null ;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Username',
                                border: UnderlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              autofocus: false,
                            ),
                            const SizedBox(height: 35,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passController ,
                              validator: (value) {
                                if(passController.text.isEmpty)
                                {
                                  return 'Invalid';
                                }
                                else
                                {
                                  return null ;
                                }
                              },
                              autofocus: false,
                              obscureText: true,
                              decoration:  InputDecoration(
                                  hintText: 'Password',

                                  border: const UnderlineInputBorder(),
                                  prefixIcon:const Icon(Icons.password_outlined),
                                  suffixIcon: IconButton(onPressed:() {

                                  }, icon:const Icon(Icons.remove_red_eye))
                              ),
                            ),
                            const SizedBox(height: 35,),
                            if (state is !InitLoginState)
                              Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate())
                                      {
                                        AuthCubit.get(context).logIn(email: userController.text, password: passController.text);
                                      }
                                      else
                                      {
                                        print('invalid data');
                                      }

                                    },
                                    clipBehavior: Clip.antiAlias,

                                    child: const Text('Login' , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16, )) ,

                                  ),
                                ),
                              ],
                            )
                            else const CircularProgressIndicator(),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                                  },
                                  clipBehavior: Clip.antiAlias,
                                  child: const Text('SignUp' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 14, )),

                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
