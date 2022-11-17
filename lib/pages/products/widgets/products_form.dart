import 'package:dashboard_feirapp/controllers/model_controller/product_controller.dart';
import 'package:dashboard_feirapp/models/model/product_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  TextEditingController dateinput = TextEditingController();

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
  String? _nomePropriedade;
  DateTime? _validade;

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
        dataValidade: _validade!,
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
      dataValidade: _validade!,
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

    dateinput.text = "";

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
        propertyModel = await propertyController.getInfoProperty(
          productModel!.idPropriedade,
          token!,
        );
        _idPropriedade = productModel!.idPropriedade;
        _nomePropriedade = propertyModel!.nome;

        _categoria = productModel!.categoria;
        _oferta = productModel!.oferta;
        _organico = productModel!.organico;
        _validade = productModel!.dataValidade;

        setState(() {
          isEdit = true;
          isLoading = false;

          String formattedDate = DateFormat('yyyy-MM-dd').format(productModel!.dataValidade);
          dateinput.text = formattedDate;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
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
                                dropDownCategory('Categoria'),
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
                                dropDownOrganic(
                                  'Organico ?',
                                  'Organico',
                                  _organico!,
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
                                dropDownOffer(
                                  'Oferta ?',
                                  'Oferta',
                                  _oferta!,
                                ),
                                _space20,
                                //!isEdit ? dropdown : Container(),
                                selectDate(),
                                _space20,
                                dropDownProperty('Propriedade'),
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
        ],
      ),
    );
  }

  decorationDropFormDropForm(String labeltext, Icon? icon) => InputDecoration(
        labelText: labeltext,
        icon: icon,
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
      );

  var categorias = [
    {'tipo': 'Frutas'},
    {'tipo': 'Verduras'},
    {'tipo': 'Legumes'}
  ];

  var trueFalse = [
    {'boolean': 'Verdadeiro'},
    {'boolean': 'Falso'}
  ];

  bool passCat = true;
  bool passOrg = true;
  bool passOff = true;
  bool passProp = true;

  Widget dropDownProperty(String labeltext) {
    return DropdownButtonFormField2(
      decoration: decorationDropFormDropForm(labeltext, null),
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
        text: isEdit ? '$_nomePropriedade $_idPropriedade' : 'Selecione uma Propriedade',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      validator: (PropertyModel? value) {
        if (value == null && isValidate) {
          return 'Campo obrigatório';
        } else {
          if (value != null && passProp) {
            _idPropriedade = value.id;
            passProp = false;
          }
        }
        return null;
      },
      onChanged: (PropertyModel? value) {},
      onSaved: (PropertyModel? value) {
        setState(() {
          if (isEdit && _idPropriedade == propertyModel!.id) {
            _idPropriedade = propertyModel!.id;
          } else {
            _idPropriedade = value!.id;
          }
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

  Widget dropDownCategory(String labeltext) {
    return DropdownButtonFormField2(
      decoration: decorationDropFormDropForm(labeltext, null),
      isExpanded: true,
      icon: Icon(Icons.arrow_downward, color: mainWhite),
      scrollbarAlwaysShow: true,
      items: categorias
          .map(
            (value) => DropdownMenuItem<String>(
              value: value['tipo'],
              child: CustomText(
                text: value['tipo'].toString(),
                color: mainWhite,
                size: Dimensions.font16,
              ),
            ),
          )
          .toList(),
      dropdownMaxHeight: 200,
      hint: CustomText(
        text: isEdit ? '$_categoria' : 'Selecione uma categoria',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      validator: (value) {
        if (value == null && isValidate) {
          return 'Campo obrigatório';
        } else {
          if (value != null && passCat) {
            _categoria = value.toString();
            passCat = false;
          }
        }
        return null;
      },
      onChanged: (value) {},
      onSaved: (value) {
        setState(() {
          if (isEdit && _categoria == productModel!.categoria) {
            _categoria = productModel!.categoria;
          } else {
            _categoria = value as String?;
          }
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
            labelText: 'Categoria',
            //hoverColor: mainStroke,
            focusColor: mainWhite,
            counterText: '',
            hintText: 'Começo do nome do Categoria...',
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
      // searchMatchFn: (rtItem, searchValue) {
      //   return (rtItem.value.nome.toLowerCase().contains(searchValue.toLowerCase()));
      // },
      // Limpa a pesquisa
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchController.clear();
        }
      },
    );
  }

  Widget dropDownOrganic(String labeltext, String hinttext, bool variavel) {
    return DropdownButtonFormField2(
      decoration: decorationDropFormDropForm(labeltext, null),
      isExpanded: true,
      icon: Icon(Icons.arrow_downward, color: mainWhite),
      scrollbarAlwaysShow: true,
      items: trueFalse
          .map(
            (value) => DropdownMenuItem<String>(
              value: value['boolean'],
              child: CustomText(
                text: value['boolean'].toString(),
                color: mainWhite,
                size: Dimensions.font16,
              ),
            ),
          )
          .toList(),
      dropdownMaxHeight: 200,
      hint: CustomText(
        text: isEdit
            ? variavel == true
                ? 'Verdadeiro'
                : 'Falso'
            : '$hinttext',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      validator: (value) {
        if (value == null && isValidate) {
          return 'Campo obrigatório';
        } else {
          if (value != null && passOrg) {
            if (value == 'Verdadeiro') {
              _organico = true;
            } else {
              _organico = false;
            }
            passOrg = false;
          }
        }
        return null;
      },
      onChanged: (value) {},
      onSaved: (value) {
        setState(() {
          if (value == 'Verdadeiro') {
            _organico = true;
          } else {
            _organico = false;
          }
        });
      },
    );
  }

  Widget dropDownOffer(String labeltext, String hinttext, bool variavel) {
    return DropdownButtonFormField2(
      decoration: decorationDropFormDropForm(labeltext, null),
      isExpanded: true,
      icon: Icon(Icons.arrow_downward, color: mainWhite),
      scrollbarAlwaysShow: true,
      items: trueFalse
          .map(
            (value) => DropdownMenuItem<String>(
              value: value['boolean'],
              child: CustomText(
                text: value['boolean'].toString(),
                color: mainWhite,
                size: Dimensions.font16,
              ),
            ),
          )
          .toList(),
      dropdownMaxHeight: 200,
      hint: CustomText(
        text: isEdit
            ? variavel == true
                ? 'Verdadeiro'
                : 'Falso'
            : '$hinttext',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      validator: (value) {
        if (value == null && isValidate) {
          return 'Campo obrigatório';
        } else {
          if (value != null && passOff) {
            if (value == 'Verdadeiro') {
              _oferta = true;
            } else {
              _oferta = false;
            }

            passOff = false;
          }
        }
        return null;
      },
      onChanged: (value) {},
      onSaved: (value) {
        setState(() {
          if (value == 'Verdadeiro') {
            _oferta = true;
          } else {
            _oferta = false;
          }
        });
      },
      // Limpa a pesquisa
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchController.clear();
        }
      },
    );
  }

  Widget selectDate() {
    return TextFormField(
      controller: dateinput, //editing controller of this TextField
      decoration: decorationDropFormDropForm(
        'Data de Validade',
        Icon(
          Icons.calendar_today,
          color: mainHover,
        ),
      ),
      style: TextStyle(
        color: mainWhite,
        fontSize: Dimensions.font16,
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            dateinput.text = formattedDate; //set output date to TextField value.

            _validade = pickedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  loadDropdown() async {
    dropDownProperty('');
  }
}

var _space20 = SizedBox(height: Dimensions.height20);
