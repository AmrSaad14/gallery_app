import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key,this.suffixIcon,
    required this.controller, required this.hintText, required this.prefix,  required this.type, this.onChanged, this.validate,
  required this.obscureText}) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData prefix;
  final bool obscureText;
  final TextInputType type;

  final Widget? suffixIcon;
  final  Function(String)? onChanged;

  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: type,
        validator:validate ,
cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hintText,

            suffixIcon: suffixIcon,
            prefixIcon:  Icon(prefix,color: Colors.black),

            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            border: buildOutlineInputBorder()));
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(16));
  }
}
