import 'package:e_commerce/core/constants.dart';
import 'package:e_commerce/core/controller/pay_cubit/pay_cubit.dart';
import 'package:e_commerce/core/controller/pay_cubit/pay_states.dart';
import 'package:e_commerce/view/screens/payment/refCodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VisaOrRefCodeScreen extends StatelessWidget {
  const VisaOrRefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayCubit(),
      child: BlocConsumer<PayCubit , PayState>(
        listener: (context, state) {
          if(state is SuccessGetRefCodePayState)
            {
              print(GetConst.refCode);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const RefCodeScreen(),));
            }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/image/visa.jpg'),fit: BoxFit.cover ),
                            borderRadius:const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/image/ref.jpg'),fit: BoxFit.cover ),
                            borderRadius:const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) ,
          );
        },
      ),
    );
  }
}
