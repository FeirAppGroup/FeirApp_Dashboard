import 'package:dashboard_feirapp/constants/style.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/drivers_table.dart';

class DriversPage extends StatelessWidget {
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
      return Container(
        height: 800,
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}

var _space = SizedBox(
  height: 20,
);

ProfileUserModel? profile;

_buildForm() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ListView(
      children: [
        _space,
        Text(
          'Nome: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text('  ${profile!.nome}'),
        _space,
        Text(
          'Email:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text('  ${profile!.email}'),
        _space,
        Text(
          'Telefone:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text('  ${profile!.telefone}'),
        _space,
        Text(
          'Documento:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text('  ${profile!.cpf}'), //TODO: fazer if para ver qual o documento a pessoa possui
        _space,
        Text(
          'Cep:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text('  ${profile!.cep}'),
        _space,
        Divider(
          thickness: 1,
          color: AppColors.blackColor.withOpacity(0.2),
        ),
      ],
    ),
  );
}
