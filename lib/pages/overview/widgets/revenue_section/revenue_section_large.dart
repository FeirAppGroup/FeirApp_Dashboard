import 'package:flutter/material.dart';

import '../../../../constants/style.dart';
import '../../../../widgets/Text/custom_text.dart';
import '../bar_chart.dart';
import 'revenue_info.dart';

class RevenueSectionLarge extends StatelessWidget {
  double value1;
  double value2;
  double value3;
  double value4;

  RevenueSectionLarge({
    Key? key,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: bgBlackCard,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          ),
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Gráfico de Utilização",
                  size: 20,
                  weight: FontWeight.bold,
                  color: textWhite,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: bgBlackMain,
                  width: 700,
                  height: 400,
                  child: ChartsDrivers(
                    title1: 'Total de Produtores',
                    value1: value1,
                    title2: 'Total de Usuários',
                    value2: value2,
                    title3: 'Pedidos Abertos',
                    value3: value3,
                    title4: 'Pedidos Fechados',
                    value4: value4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
