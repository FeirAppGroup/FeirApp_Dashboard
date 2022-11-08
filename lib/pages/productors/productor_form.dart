import 'package:dashboard_feirapp/models/dtos/user_edit_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../controllers/model_controller/user_controller.dart';
import '../../models/dtos/user_login_dto.dart';
import '../../models/enum/type_user_enum.dart';
import '../../models/model/user_model.dart';
import '../../utils/dimensions.dart';
import '../../widgets/Text/custom_text.dart';
import '../../widgets/TextFormField/custom_text_form_field.dart';
import '../productors/widgets/card_title.dart';

bool isOk = false;
bool isClicked = false;

class ProductorForm extends StatefulWidget {
  final int? id;
  const ProductorForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductorForm> createState() => _ProductorFormState();
}

class _ProductorFormState extends State<ProductorForm> {
  UserModel? userModel;
  var userController = Get.find<UserController>();

  UserLoginDto? user;
  String? token;
  final controller = TextEditingController();

  String? _fullName;
  String? _phoneNumber;
  String? _email;
  String? _cep;
  String? _password;
  String? _cpf;
  String? _cnpj;
  String? _dap;

  bool _passwordVisible = false;
  bool isLoading = true;
  bool isEdit = false;
  bool pass = false;

  var tipo = TipoUsuarioEnum.produtor;

  Future<void> _registerUser() async {
    var resp = await userController.registerNewUser(
      UserModel(
        nome: _fullName!,
        telefone: _phoneNumber!,
        email: _email!,
        cep: _cep!,
        senha: _password!,
        tipo: 1,
        dap: _dap!,
        cnpj: _cnpj!,
        cpf: _cpf!,
      ),
    );

    setState(() {
      isClicked = true;

      if (resp == 'Usuário cadastrado com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  Future<void> _updateUser() async {
    UserEditDto userEdit = UserEditDto(
      nome: _fullName!,
      telefone: _phoneNumber!,
      cep: _cep!,
      cnpj: _cnpj!,
      tipo: 1,
    );

    if (_email! != userModel!.email) {
      userEdit.email = _email!;
    }
    if (_dap! != userModel!.dap) {
      userEdit.dap = _dap!;
    }
    if (_cpf! != userModel!.cpf) {
      userEdit.cpf = _cpf!;
    }

    var resp = await userController.updateInfoProfileUser(
      widget.id!.toInt(),
      token!,
      userEdit,
    );

    setState(() {
      isClicked = true;

      if (resp == 'Usuário atualizado com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    //print(sharedUser.getString('user'));
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);
    }

    if (widget.id != null && token != null && !pass) {
      userModel = await userController.getInfoProfileUser(
        widget.id!,
        token!,
      );
      pass = true;

      setState(() {
        isEdit = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.height60,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CardTitle(title: !isEdit ? "Adicionar" : "Edição", isActive: true),
                  ],
                ),
              ),
              isLoading
                  ? SpinKitCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: textWhite,
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.height50),
                      child: Container(
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
                                  initialValue: isEdit ? userModel!.nome : "",
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
                                  initialValue: isEdit ? userModel!.email : "",
                                  textInputType: TextInputType.emailAddress,
                                  text: 'Email',
                                  suffixIcon: const Icon(Icons.email),
                                  validator: _validarEmail,
                                  onSaved: (value) => _email = value,
                                ),
                                _space20,
                                !isEdit
                                    ? CustomTextFormField(
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
                                      )
                                    : Container(),
                                !isEdit
                                    ? Container(
                                        padding: EdgeInsets.only(top: Dimensions.font10),
                                        child: Text(
                                          'Mínimo de 8 caracteres, 1 letra maiúscula, 1 letra minúscula, 1 número',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: Dimensions.font12,
                                            fontWeight: FontWeight.w400,
                                            color: mainWhite,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                _space20,
                                CustomTextFormField(
                                  initialValue: isEdit ? userModel!.cpf : "",
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
                                  initialValue: isEdit ? userModel!.telefone.toString() : "",
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
                                  initialValue: isEdit ? userModel!.cep : "",
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
                                  initialValue: isEdit ? userModel!.cnpj : "",
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
                                  initialValue: isEdit ? userModel!.dap : "",
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
                                SizedBox(
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
                                                isEdit ? _updateUser() : _registerUser();
                                              },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: active,
                                          ),
                                          child: CustomText(
                                            text: "Continuar",
                                            color: textWhite,
                                            size: Dimensions.font16,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                isClicked
                                    ? isOk
                                        ? Column(
                                            children: [
                                              CustomText(
                                                text: !isEdit
                                                    ? "Cadastro realizado com Sucesso "
                                                    : "Usuário atualizado com Sucesso !",
                                                size: Dimensions.font18,
                                                color: textWhite,
                                              ),
                                              _space20,
                                              ButtonWidget(
                                                text: "Prosseguir",
                                                width: Dimensions.width150,
                                                height: Dimensions.height40,
                                                backgroundColor: active,
                                                textColor: textWhite,
                                                onTap: () => navigationController.navigateTo(productorPageRoute),
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              CustomText(
                                                text: !isEdit
                                                    ? "Erro a realizar o cadastro"
                                                    : "Erro na atualização do usuário",
                                                size: Dimensions.font18,
                                                color: tertiaryRed,
                                              ),
                                            ],
                                          )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
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

var _space20 = SizedBox(height: Dimensions.height20);
