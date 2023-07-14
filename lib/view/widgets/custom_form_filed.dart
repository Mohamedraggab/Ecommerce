import 'package:flutter/material.dart';

Widget customTextFormField(
{
  required TextEditingController controller ,
  required String label ,
  Widget? suffixIcon ,
  Widget? prefix ,
  required InputBorder? borderType,

})
{
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextFormField(
      decoration:  InputDecoration(
        hintText: label,
        border: borderType,
        suffixIcon: suffixIcon,
        prefixIcon: prefix,
      ),
      controller: controller ,
      validator: (value) {
        if(controller.text.isEmpty)
        {
          return 'Invalid';
        }
        else
        {
          return null ;
        }
      },

    ),
  );
}