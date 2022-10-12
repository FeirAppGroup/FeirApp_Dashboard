import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/style.dart';
import '../../routing/routes.dart';
import '../../widgets/Text/custom_text.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _passwordVisible = false;

  String? _email;

  String? _password;

  final _formKey = GlobalKey<FormState>();

  final formValidVN = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.roboto(
                      color: textWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome back to the admin panel",
                    color: textBlue,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                onChanged: () {
                  formValidVN.value = _formKey.currentState?.validate() ?? false;
                },
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                        fontSize: 15,
                        color: textWhite,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: textBlue,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: textWhite,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: mainHover,
                        prefixIcon: Icon(
                          Icons.email,
                          color: mainBlack,
                        ),
                        contentPadding: const EdgeInsets.all(20),
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
                      validator: _validarEmail,
                      onSaved: (value) => _email = value,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                style: TextStyle(
                  fontSize: 15,
                  color: textWhite,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: textBlue,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: textWhite,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: mainHover,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: mainBlack,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: mainBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required field';
                  } else {
                    _password = value;
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Forgot password",
                    color: textLiteblue,
                  ),
                  Text(
                    'Forgot password',
                    style: TextStyle(
                      color: textLiteblue,
                      decoration: TextDecoration.underline,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.offNamed(rootRoute);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: active,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Do not have admin credentials ?"),
                    TextSpan(
                      text: "Request credentials !",
                      style: TextStyle(color: active),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _validarEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Required field";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid e-mail";
  } else {
    return null;
  }
}
