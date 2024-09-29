import 'package:flutter/material.dart';
import 'package:fyp/view/mycolors.dart';

// ignore: must_be_immutable
class DecoratedTextField extends StatelessWidget {
  TextEditingController? controller;
  String label;
  bool? obscureText;
  bool? readOnly;
  Icon? icon;
  void Function()? ontap;
  String? Function(String? value)? validator;


  DecoratedTextField(
      {this.controller,
      required this.label,
      this.readOnly,
      this.obscureText,
      this.icon,
      this.ontap,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        alignment:Alignment.center,
        padding: const EdgeInsets.only(left: 5, right: 20,bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: angryFlamingo),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          
          validator:validator,
            onTap: ontap,
            controller: controller,
            obscureText: obscureText ?? false,
            readOnly: readOnly??false,
            
            decoration: InputDecoration(
                
                prefixIcon: icon ?? const Icon(Icons.abc_rounded),
                border: InputBorder.none,
                hintText: label)));
  }
}
