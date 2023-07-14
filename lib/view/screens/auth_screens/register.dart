import 'package:e_commerce/core/controller/auth_controller/auth_cubit.dart';
import 'package:e_commerce/core/controller/auth_controller/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit , AuthState>
        (
        listener: (context, state) {

        },
        builder: (context, state) {
          var emailController = TextEditingController();
          var passController = TextEditingController();
          var phoneController = TextEditingController();
          var userController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child:const Center(
                            child: Text('Sign Up', style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w700 , color: Colors.blue),)),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: userController ,
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
                              autofocus: true,
                            ),
                            const SizedBox(height: 35,),
                            TextFormField(
                              controller: phoneController ,
                              validator: (value) {
                                if(phoneController.text.isEmpty)
                                {
                                  return 'Invalid';
                                }
                                else
                                {
                                  return null ;
                                }
                              },
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Phone',
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(Icons.password_outlined),
                              ),
                            ),
                            const SizedBox(height: 35,),
                            TextFormField(
                              controller: emailController ,
                              validator: (value) {
                                if(emailController.text.isEmpty)
                                {
                                  return 'Invalid';
                                }
                                else
                                {
                                  return null ;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: UnderlineInputBorder(),
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                              autofocus: true,
                            ),
                            const SizedBox(height: 35,),
                            TextFormField(
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
                              decoration: const InputDecoration(
                                hintText: 'PassWord',
                                border: UnderlineInputBorder(),
                                prefixIcon: Icon(Icons.password),
                              ),
                              autofocus: true,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate())
                                      {
                                        AuthCubit.get(context).register(
                                            email: emailController.text,
                                            password: passController.text,
                                            phone: phoneController.text,
                                            userName: userController.text);
                                      }
                                      else
                                      {
                                        print('invalid data');
                                      }

                                    },
                                    clipBehavior: Clip.antiAlias,
                                    child: const Text('Login' , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16, )),

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                                  },
                                  clipBehavior: Clip.antiAlias,
                                  child: const Text('Login' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 14, )),

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
