import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text('Reference code'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You Should Go To Any Market To Pay',style: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 18)),
          const SizedBox(height: 10,),
          const Text('This Is Your Reference Code '),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 5 ,color: Colors.black12 ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 70,
              child: Text(GetConst.refCode , style:const TextStyle(color: Colors.white ,fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
