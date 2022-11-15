import 'package:dashboard_feirapp/controllers/model_controller/property_controller.dart';
import 'package:dashboard_feirapp/models/model/property_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/widgets/Text/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/controllers.dart';
import '../../../constants/style.dart';
import '../../../controllers/model_controller/user_controller.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../models/model/user_model.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/button_widget.dart';
import '../../../widgets/Cards/card_bottom_form.dart';
import '../../../widgets/Cards/card_title_form.dart';
import '../../../widgets/TextFormField/custom_text_form_field.dart';

class PropertyForm extends StatefulWidget {
  final int? id;

  const PropertyForm({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  UserModel? userModel;
  var userController = Get.find<UserController>();
  List<UserModel> listProductors = [];

  PropertyModel? propertyModel;
  var propertyController = Get.find<PropertyController>();

  UserLoginDto? user;
  String? token;

  final controller = TextEditingController();
  final searchController = TextEditingController();

  var dropdown;

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  int? _idUsuario;
  String? _matricula;
  String? _nome;
  String? _endereco;
  String? _localizacao;
  double? _tamanho;
  int? _quantidadeTrabalhador;
  String? _uriFoto;

  bool isLoading = true;
  bool isEdit = false;
  bool pass = false;
  bool isOk = false;
  bool isClicked = false;
  bool reload = false;
  bool isValidate = false;

  Future<void> _registerProperty() async {
    var resp = await propertyController.registerNewProperty(
      PropertyModel(
        idUsuario: _idUsuario!,
        matricula: _matricula!,
        nome: _nome!,
        endereco: _endereco!,
        localizacao: _localizacao!,
        tamanho: _tamanho!,
        quantidadeTrabalhador: _quantidadeTrabalhador!,
        uriFoto: _uriFoto!,
      ),
    );

    setState(() {
      isClicked = true;

      if (resp == 'Propriedade cadastrada com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  Future<void> _updateProperty() async {
    PropertyModel propertyEdit = PropertyModel(
      idUsuario: propertyModel!.idUsuario,
      matricula: _matricula!,
      nome: _nome!,
      endereco: _endereco!,
      localizacao: _localizacao!,
      tamanho: _tamanho!,
      quantidadeTrabalhador: _quantidadeTrabalhador!,
      uriFoto: _uriFoto!,
    );

    var resp = await propertyController.updateInfoProperty(
      widget.id!.toInt(),
      token!,
      propertyEdit,
    );
    setState(() {
      isClicked = true;

      if (resp == 'Propriedade atualizada com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadPref();
  }

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;

      userController.getProductorList(token!);
      listProductors = userController.productorList;
      print(listProductors);

      loadDropdown();

      if (widget.id != null && token != null && !pass) {
        propertyModel = await propertyController.getInfoProperty(
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
  }

  loadDropdown() async {
    dropdown = DropdownButtonFormField2(
      decoration: InputDecoration(
        labelText: 'Produtor',
        labelStyle: TextStyle(
          fontSize: Dimensions.font16,
          color: textWhite,
          fontWeight: FontWeight.w400,
        ),
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
        filled: true,
        fillColor: mainHover,
        alignLabelWithHint: true,
      ),

      isExpanded: true,
      icon: Icon(Icons.arrow_downward, color: mainWhite),
      scrollbarAlwaysShow: true,
      items: listProductors
          .map(
            (UserModel rtItem) => DropdownMenuItem<UserModel>(
              value: rtItem,
              child: CustomText(
                text: '${rtItem.nome} (${rtItem.id})',
                color: mainWhite,
                size: Dimensions.font16,
              ),
            ),
          )
          .toList(),
      dropdownMaxHeight: 200,
      hint: CustomText(
        text: _nome != null && _idUsuario != null ? '${_nome} (${_idUsuario})' : 'Selecione um Produtor',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      onChanged: (UserModel? newValue) {},
      onSaved: (UserModel? newValue) {
        setState(() {
          _idUsuario = newValue!.id;
        });
      },
      // Search Field
      searchController: searchController,
      searchInnerWidget: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 4,
          right: 8,
          left: 8,
        ),
        child: TextFormField(
          controller: searchController,
          style: TextStyle(
            color: mainWhite,
            fontSize: Dimensions.font16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: Dimensions.font16,
              color: mainWhite,
              fontWeight: FontWeight.w400,
            ),
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
            filled: true,
            alignLabelWithHint: true,
            isDense: false,
            labelText: 'Produtor',
            //hoverColor: mainStroke,
            focusColor: mainWhite,
            counterText: '',
            hintText: 'Começo do nome do produtor...',
            hintStyle: TextStyle(
              fontSize: Dimensions.font16,
              color: textWhite,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      // Verifica se existe
      searchMatchFn: (rtItem, searchValue) {
        return (rtItem.value.nome.toLowerCase().contains(searchValue.toLowerCase()));
      },
      // Limpa a pesquisa
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchController.clear();
        }
      },
    );
  }

  _reloadPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PropertyForm()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                CardTitleForm(
                  title: !isEdit ? "Adicionar" : "Edição",
                  isActive: true,
                  button: ButtonWidget(
                    text: 'Cancelar',
                    backgroundColor: active,
                    height: Dimensions.height40,
                    width: Dimensions.width150,
                    textColor: textWhite,
                    onTap: () {
                      navigationController.navigateTo(propertyPageRoute);
                    },
                  ),
                ),
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
                              initialValue: isEdit ? propertyModel!.matricula : "",
                              textInputType: TextInputType.text,
                              text: 'Matricula',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _matricula = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _matricula = value,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.nome : "",
                              textInputType: TextInputType.name,
                              text: 'Nome Propriedade',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _nome = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _nome = value,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.endereco : "",
                              textInputType: TextInputType.text,
                              text: 'Endereço',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _endereco = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _endereco = value,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.localizacao : "",
                              textInputType: TextInputType.text,
                              text: 'Localização',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _localizacao = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _localizacao = value,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.tamanho.toString() : "",
                              textInputType: TextInputType.number,
                              text: 'Tamanho',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                } else {
                                  _tamanho = double.parse(value);
                                }
                                return null;
                              },
                              onSaved: (value) => _tamanho,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.quantidadeTrabalhador.toString() : "",
                              textInputType: TextInputType.number,
                              text: 'Quantidade de trabalhadores',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                } else {
                                  _quantidadeTrabalhador = int.parse(value);
                                }
                                return null;
                              },
                              onSaved: (value) => _quantidadeTrabalhador,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? propertyModel!.uriFoto : "",
                              textInputType: TextInputType.number,
                              text: 'Uri Foto',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _uriFoto = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _uriFoto = value,
                            ),
                            _space20,
                            !isEdit ? dropdown : Container(),
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
                                            isEdit ? _updateProperty() : _registerProperty();
                                            isValidate = true;
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
                                                : "Propriedade atualizada com Sucesso !",
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
                                            onTap: () {
                                              setState(() {
                                                isClicked = true;
                                              });
                                              navigationController.navigateTo(propertyPageRoute);
                                            },
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          CustomText(
                                            text: !isEdit
                                                ? "Erro a realizar o cadastro"
                                                : "Erro na atualização do propriedade",
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
          CardBottomForm(
            marginLeft: Dimensions.width20,
            marginRight: Dimensions.width20,
            marginBottom: Dimensions.height30,
          ),
        ],
      ),
    );
  }
}

var _space20 = SizedBox(height: Dimensions.height20);
