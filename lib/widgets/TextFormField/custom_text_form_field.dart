import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../utils/dimensions.dart';

class CustomTextFormField extends StatelessWidget {
  bool? obscureText;
  String text;
  TextInputType textInputType;
  Icon? suffixIcon;
  IconButton? suffixIconButton;
  Icon? prefixIcon;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  void Function(String?)? onChanged;

  CustomTextFormField({
    Key? key,
    this.obscureText,
    required this.text,
    required this.textInputType,
    this.suffixIcon,
    this.suffixIconButton,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscureText ?? false,
      style: TextStyle(
        fontSize: Dimensions.font16,
        color: textWhite,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400,
      ),
      cursorColor: textBlue,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          fontSize: Dimensions.font16,
          color: textWhite,
          //fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: mainHover,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIconButton ?? suffixIcon,
        contentPadding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height20,
          top: Dimensions.height20,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainWhite),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tertiaryRed),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tertiaryRed),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
