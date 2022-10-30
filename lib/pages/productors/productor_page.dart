import 'package:dashboard_feirapp/constants/style.dart';
import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/models/enum/type_user_enum.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';
import 'package:dashboard_feirapp/widgets/TextFormField/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../layout.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/drivers_table.dart';

class ProductorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  height: Dimensions.height50,
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? Dimensions.height56 : Dimensions.height5,
                  ),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: Dimensions.font24,
                    color: mainWhite,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                  onTap: () {
                    modalShow(context);
                  },
                  text: 'Adicionar Produtor',
                  backgroundColor: active,
                  height: Dimensions.height40,
                  width: Dimensions.width150,
                  textColor: textWhite,
                ),
              ],
            ),
          ),
          DriversTable()
        ],
      ),
    );
  }
}

modalShow(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: Dimensions.screenHeight + 200,
          width: double.infinity,
          color: bgBlackMain,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: 'Adicionar Produtor',
                      size: Dimensions.font24,
                      color: textWhite,
                    ),
                    ElevatedButton(
                      child: const Text('Voltar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                BuildForm()
              ],
            ),
          ),
        ),
      );
    },
  );
}

var _space16 = SizedBox(height: Dimensions.height16);
var _space20 = SizedBox(height: Dimensions.height20);

class BuildForm extends StatefulWidget {
  const BuildForm({Key? key}) : super(key: key);

  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  UserModel? userModel;
  var userController = Get.find<UserController>();

  String? _fullName;
  String? _phoneNumber;
  String? _email;
  String? _cep;
  String? _password;
  String? _cpf;
  String? _cnpj;
  String? _dap;

  bool agree = false;
  bool _passwordVisible = false;
  bool isLoading = false;

  var tipo = TipoUsuarioEnum.produtor;

  Future<void> _registerUser() async {
    var resp = await userController.registerNewUser(
      UserModel(
        nome: _fullName!,
        telefone: _phoneNumber!,
        email: _email!,
        cep: _cep!,
        senha: _password!,
        tipoUsuario: 3,
        dap: _dap!,
        cnpj: _cnpj!,
        cpf: _cpf!,
      ),
    );
    showMessage(context, resp);
  }

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          onChanged: () {
            formValidVN.value = _formKey.currentState?.validate() ?? false;
          },
          child: Column(
            children: [
              _space20,
              CustomTextFormField(
                textInputType: TextInputType.name,
                text: 'Nome Completo',
                suffixIconButton: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _fullName = value;
                  }
                  return null;
                },
                onSaved: (value) => _fullName = value,
              ),
              _space20,
              CustomTextFormField(
                textInputType: TextInputType.emailAddress,
                text: 'Email',
                suffixIcon: const Icon(Icons.email),
                validator: _validarEmail,
                onSaved: (value) => _email = value,
              ),
              _space20,
              CustomTextFormField(
                textInputType: TextInputType.visiblePassword,
                text: 'Senha',
                suffixIconButton: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                obscureText: !_passwordVisible,
                validator: _validatePassword,
                onChanged: (value) => _password = value,
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  'Mínimo de 8 caracteres, 1 letra maiúscula, 1 letra minúscula, 1 número',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: Dimensions.font12,
                    fontWeight: FontWeight.w400,
                    color: mainWhite,
                  ),
                ),
              ),
              _space20,
              CustomTextFormField(
                textInputType: TextInputType.number,
                text: 'CPF',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _cpf = value;
                  }
                  return null;
                },
                onSaved: (value) => _cpf = value,
                suffixIcon: Icon(
                  Icons.document_scanner,
                ),
              ),
              _space20,
              //TODO: adicionar mascara para o telefone cep e cpf
              CustomTextFormField(
                textInputType: TextInputType.phone,
                text: 'Telefone',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _phoneNumber = value;
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value,
                suffixIcon: const Icon(
                  Icons.phone,
                ),
              ),
              _space20,
              CustomTextFormField(
                text: 'CEP',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _cep = value;
                  }
                  return null;
                },
                onSaved: (value) => _cep = value,
              ),
              _space20,
              CustomTextFormField(
                text: 'CNPJ',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _cnpj = value;
                  }
                  return null;
                },
                onSaved: (value) => _cnpj = value,
              ),
              _space20,
              CustomTextFormField(
                text: 'DAP',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    _dap = value;
                  }
                  return null;
                },
                onSaved: (value) => _dap = value,
              ),
              _space20,
              Container(
                width: double.infinity,
                child: ValueListenableBuilder<bool>(
                  valueListenable: formValidVN,
                  builder: (context, formValid, child) {
                    return InkWell(
                      onTap: !formValid
                          ? null
                          : () {
                              _formKey.currentState!.validate();
                              _formKey.currentState!.save();
                              _registerUser();
                            },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: active,
                        ),
                        child: CustomText(
                          text: "Cadastrar",
                          color: textWhite,
                          size: Dimensions.font16,
                        ),
                      ),
                    );
                  },
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
    return "Campo obrigatório";
  } else if (!regExp.hasMatch(value)) {
    return "E-mail inválido";
  } else {
    return null;
  }
}

String? _validatePassword(String? value) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  if (value!.isEmpty) {
    return 'Campo obrigatório';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Digite uma senha válida';
    } else {
      return null;
    }
  }
}

showMessage(BuildContext context, String text) {
  // configura o button
  Widget okButton = InkWell(
    child: Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: active,
      ),
      child: Text(
        "OK",
        style: TextStyle(
          color: textWhite,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    onTap: () {
      Get.toNamed(rootRoute);
    },
  );

  //TODO:: Fazer lógica para quando retornar erro trocar a cor do button e o title
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        40,
      ),
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   width: 190,
        //   height: 250,
        //   child: Image.asset(
        //     'assets/images/congratulations.png',
        //     fit: BoxFit.contain,
        //   ),
        // ),
        SizedBox(
          height: 24,
        ),
        Text(
          "Cadastro",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
    contentPadding: EdgeInsets.all(24),
    actionsPadding: EdgeInsets.only(bottom: 16),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
