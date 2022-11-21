import 'package:dashboard_feirapp/controllers/model_controller/inventory_controller.dart';
import 'package:dashboard_feirapp/models/model/inventory_model.dart';
import 'package:dashboard_feirapp/models/model/product_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/controllers.dart';
import '../../../constants/style.dart';
import '../../../controllers/model_controller/product_controller.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/button_widget.dart';
import '../../../widgets/Cards/card_bottom_form.dart';
import '../../../widgets/Cards/card_title_form.dart';
import '../../../widgets/Text/custom_text.dart';
import '../../../widgets/TextFormField/custom_text_form_field.dart';

class InventoryForm extends StatefulWidget {
  final int? id;

  const InventoryForm({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  UserLoginDto? user;
  String? token;

  InventoryModel? inventoryModel;
  var inventoryController = Get.find<InventoryController>();

  ProductModel? productModel;
  var productController = Get.find<ProductController>();
  List<ProductModel> listProducts = [];

  final controller = TextEditingController();
  final searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  int? _idProduto;
  int? _quantidade;

  String? _nomeProduto;

  bool isLoading = true;
  bool isEdit = false;
  bool pass = false;
  bool isOk = false;
  bool isClicked = false;
  bool isValidate = false;

  Future<void> _registerInventory() async {
    var resp = await inventoryController.registerNewInventory(
      InventoryModel(
        idProduto: _idProduto!,
        quantidade: _quantidade!,
      ),
    );

    setState(() {
      isClicked = true;

      if (resp == 'Estoque cadastrado com sucesso!') {
        isOk = true;
      } else {
        isOk = false;
      }
    });
  }

  Future<void> _updateInventory() async {
    InventoryModel inventoryEdit = InventoryModel(
      idProduto: _idProduto!,
      quantidade: _quantidade!,
    );

    var resp = await inventoryController.updateInfoInventory(
      widget.id!.toInt(),
      token!,
      inventoryEdit,
    );
    setState(() {
      isClicked = true;

      if (resp == 'Estoque atualizado com sucesso!') {
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

      productController.getProductsList(token!);
      listProducts = productController.productsList;
      print(listProducts);

      if (widget.id != null && token != null && !pass) {
        inventoryModel = await inventoryController.getInfoInventory(
          widget.id!,
          token!,
        );
        pass = true;
        productModel = await productController.getInfoProduct(
          inventoryModel!.idProduto,
          token!,
        );

        _idProduto = inventoryModel!.idProduto;
        _nomeProduto = productModel!.nome;

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

  bool passProd = true;

  Widget dropDown() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        labelText: 'Produto',
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
      items: listProducts
          .map(
            (ProductModel rtItem) => DropdownMenuItem<ProductModel>(
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
        text: isEdit ? '$_nomeProduto $_idProduto' : 'Selecione um Produto',
        size: Dimensions.font16,
        color: textWhite,
      ),
      dropdownDecoration: BoxDecoration(
        color: mainHover,
      ),
      validator: (ProductModel? value) {
        if (value == null && isValidate) {
          return 'Campo obrigatório';
        } else {
          if (value != null && passProd) {
            _idProduto = value.id;
            passProd = false;
          }
        }
        return null;
      },
      onChanged: (ProductModel? newValue) {},
      onSaved: (ProductModel? newValue) {
        setState(() {
          _idProduto = newValue!.id;
        });
      },
      //Search Field
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
            labelText: 'Produto',
            focusColor: mainWhite,
            counterText: '',
            hintText: 'Começo do nome do produto...',
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
                          navigationController.navigateTo(inventoryPageRoute);
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
                                dropDown(),
                                _space20,
                                CustomTextFormField(
                                  initialValue: isEdit ? inventoryModel!.quantidade.toString() : "",
                                  textInputType: TextInputType.number,
                                  text: 'Quantidade',
                                  suffixIconButton: null,
                                  validator: (value) {
                                    if (value == null || value.isEmpty && !isValidate) {
                                      return 'Campo obrigatório';
                                    } else {
                                      _quantidade = int.parse(value);
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _quantidade,
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
                                                isEdit ? _updateInventory() : _registerInventory();
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
                                                    : "Estoque atualizado com Sucesso !",
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
                                                  navigationController.navigateTo(inventoryPageRoute);
                                                },
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              CustomText(
                                                text: !isEdit
                                                    ? "Erro a realizar o cadastro"
                                                    : "Erro na atualização do estoque",
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
}

var _space20 = SizedBox(height: Dimensions.height20);
