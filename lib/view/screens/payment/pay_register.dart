import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/controller/pay_cubit/pay_cubit.dart';
import 'package:e_commerce/core/controller/pay_cubit/pay_states.dart';
import 'package:e_commerce/view/widgets/custom_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PayRegister extends StatelessWidget {
  const PayRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayCubit()..getToken(),
      child: BlocConsumer<PayCubit , PayState>(
        listener: (context, state) {
          if(state is SuccessGetFinalTokenPayState)
          {
            launchURL();
          }
        },
        builder:(context, state) {
          var firstNameController = TextEditingController();
          var lastNameController = TextEditingController();
          var emailController = TextEditingController();
          var phoneController = TextEditingController();
          var priceController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          var cubit = PayCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0.0,
                title:const Text('Payment Integration'),
              ),
              body: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            decoration:const BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/image/download.png') ,fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: customTextFormField(controller: firstNameController, label: 'First Name', borderType:const OutlineInputBorder() ,prefix:const Icon(Icons.person))),
                            Expanded(child: customTextFormField(controller: lastNameController, label: 'Last Name', borderType: const OutlineInputBorder() , prefix:const Icon(Icons.person))),
                          ],
                        ),
                        customTextFormField(controller: emailController, label: 'Email', borderType: const OutlineInputBorder(), prefix:const Icon(Icons.email)),
                        customTextFormField(controller: phoneController, label: 'Phone', borderType: const OutlineInputBorder() ,prefix:const Icon(Icons.phone)),
                        customTextFormField(controller: priceController, label: 'Price', borderType: const OutlineInputBorder() , prefix:const Icon(Icons.currency_exchange)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.getOrderId(
                                      price: priceController.text,
                                      firstName: firstNameController.text,
                                      phoneNumber: phoneController.text,
                                      lastName: lastNameController.text
                                  );
                                }

                              },
                              child:const SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('Register' ,textScaleFactor: 1.4,),
                                  )))),
                        )
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


launchURL() async {
  final uri = Uri.parse("https://accept.paymob.com/api/acceptance/iframes/771056?payment_token=${GetConst.finalToken}");
  if (await canLaunchUrl(uri)){
    await launchUrl(uri);
  } else {
    // can't launch url
  }
}