import 'package:flutter/material.dart';

Widget customButton(
{
 required context ,
 required String title ,
})
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        clipBehavior: Clip.antiAlias,
        decoration:const  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        width: MediaQuery.of(context).size.width * 0.7 ,
        child: ElevatedButton(
           onPressed: () {

           },
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:  Text(title , style: const TextStyle(fontWeight: FontWeight.w600 , fontSize: 16, )),
          ),

        ),
      ),
    ],
  );
}