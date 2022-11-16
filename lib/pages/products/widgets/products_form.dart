import 'package:dashboard_feirapp/controllers/model_controller/product_controller.dart';
import 'package:dashboard_feirapp/models/model/product_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/controllers.dart';
import '../../../constants/style.dart';
import '../../../controllers/model_controller/property_controller.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../models/model/property_model.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/button_widget.dart';
import '../../../widgets/Cards/card_bottom_form.dart';
import '../../../widgets/Cards/card_title_form.dart';
import '../../../widgets/Text/custom_text.dart';
import '../../../widgets/TextFormField/custom_text_form_field.dart';

class ProductsForm extends StatefulWidget {
  final int? id;
  const ProductsForm({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<ProductsForm> createState() => _ProductsFormState();
}

class _ProductsFormState extends State<ProductsForm> {
  PropertyModel? propertyModel;
  var propertyController = Get.find<PropertyController>();

  ProductModel? productModel;
  var productController = Get.find<ProductController>();

  List<PropertyModel>? listProperty = [];

  UserLoginDto? user;
  String? token;

  final controller = TextEditingController();
  final searchController = TextEditingController();

  var dropdown;

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  int? _idPropriedade;
  String? _nome;
  String? _categoria;
  String? _descricao;
  bool? _organico;
  String? _urlFoto;
  double? _valor;
  bool? _oferta;

  bool isLoading = true;
  bool isEdit = false;
  bool pass = false;
  bool isOk = false;
  bool isClicked = false;
  bool isValidate = false;

  Future<void> _registerProduct() async {
    var resp = await productController.registerNewProduct(
      ProductModel(
        idPropriedade: _idPropriedade!,
        nome: _nome!,
        categoria: _categoria!,
        descricao: _descricao!,
        organico: _organico!,
        urlFoto: _urlFoto!,
        valor: _valor!,
        oferta: _oferta!,
      ),
    );

    setState(() {
      isClicked = true;

      if (resp == 'Produto cadastrado com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  Future<void> _updateProduct() async {
    ProductModel productEdit = ProductModel(
      idPropriedade: _idPropriedade!,
      nome: _nome!,
      categoria: _categoria!,
      descricao: _descricao!,
      organico: _organico!,
      urlFoto: _urlFoto!,
      valor: _valor!,
      oferta: _oferta!,
    );

    var resp = await productController.updateInfoProduct(
      widget.id!.toInt(),
      token!,
      productEdit,
    );
    setState(() {
      isClicked = true;

      if (resp == 'Produto atualizado com sucesso!') {
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

      propertyController.getPropertyList(token!);
      listProperty = propertyController.propertyList;
      print(listProperty);

      loadDropdown();

      if (widget.id != null && token != null && !pass) {
        productModel = await productController.getInfoProduct(
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
        labelText: 'Propriedade',
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
      items: listProperty!
          .map(
            (PropertyModel rtItem) => DropdownMenuItem<PropertyModel>(
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
        text: _nome != null && _idPropriedade != null ? '${_nome} (${_idPropriedade})' : 'Selecione uma Propriedade',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      onChanged: (PropertyModel? newValue) {},
      onSaved: (PropertyModel? newValue) {
        setState(() {
          _idPropriedade = newValue!.id;
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
            labelText: 'Propriedade',
            //hoverColor: mainStroke,
            focusColor: mainWhite,
            counterText: '',
            hintText: 'Começo do nome do Propriedade...',
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
                      navigationController.navigateTo(productPageRoute);
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
                              initialValue: isEdit ? productModel!.nome : "",
                              textInputType: TextInputType.text,
                              text: 'Nome',
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
                            CustomText(
                              text: 'DROPDOWN CATEGORIA',
                              color: mainWhite,
                              size: Dimensions.font24,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? productModel!.descricao : "",
                              textInputType: TextInputType.multiline,
                              text: 'Descrição',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _descricao = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _descricao = value,
                            ),
                            _space20,
                            CustomText(
                              text: 'DROPDOWN True/FALSE organico',
                              color: mainWhite,
                              size: Dimensions.font24,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? productModel!.urlFoto : "",
                              textInputType: TextInputType.url,
                              text: 'URL Foto',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _urlFoto = value;
                                }
                                return null;
                              },
                              onSaved: (value) => _urlFoto = value,
                            ),
                            _space20,
                            CustomTextFormField(
                              initialValue: isEdit ? productModel!.valor.toString() : "",
                              textInputType: TextInputType.number,
                              text: 'Preço',
                              suffixIconButton: null,
                              validator: (value) {
                                if (value == null || value.isEmpty && !isValidate) {
                                  return 'Campo obrigatório';
                                } else {
                                  _valor = double.parse(value);
                                }
                                return null;
                              },
                              onSaved: (value) => _valor,
                            ),
                            _space20,
                            CustomText(
                              text: 'DROPDOWN TRUE/FALSE oferta',
                              color: mainWhite,
                              size: Dimensions.font24,
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
                                            isEdit ? _updateProduct() : _registerProduct();
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
                                                : "Produto atualizado com Sucesso !",
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
                                              navigationController.navigateTo(productPageRoute);
                                            },
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          CustomText(
                                            text: !isEdit
                                                ? "Erro a realizar o cadastro"
                                                : "Erro na atualização do produto",
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
