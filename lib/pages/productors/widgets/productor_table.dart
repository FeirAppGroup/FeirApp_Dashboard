import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/Text/custom_text.dart';

/// Example without a datasource
class ProductorTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height16),
      margin: EdgeInsets.only(bottom: Dimensions.height30),
      decoration: BoxDecoration(
        color: mainBlack,
        borderRadius: BorderRadius.circular(Dimensions.radius8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, Dimensions.height5),
            color: lightGrey.withOpacity(.1),
            blurRadius: Dimensions.radius12,
          ),
        ],
        border: Border.all(
          color: mainWhite,
          width: .5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataTable(
            columns: [
              DataColumn2(
                label: CustomText(
                  text: 'Nome',
                  color: textWhite,
                ),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: CustomText(
                  text: 'Location',
                  color: textWhite,
                ),
              ),
              DataColumn(
                label: CustomText(
                  text: 'Rating',
                  color: textWhite,
                ),
              ),
              DataColumn(
                label: CustomText(
                  text: 'Action',
                  color: textWhite,
                ),
              ),
            ],
            dataRowHeight: 60,
            rows: List<DataRow>.generate(
              15,
              (index) => DataRow(
                cells: [
                  DataCell(
                    CustomText(
                      text: "Santos Enoque San Francisco",
                      color: textWhite,
                    ),
                  ),
                  DataCell(CustomText(
                    text: "New York City",
                    color: textWhite,
                  )),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: starTableColor,
                          size: Dimensions.icon18,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        CustomText(
                          text: "4.$index",
                          color: textWhite,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: active, width: .5),
                        color: textLiteblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Assign ",
                        color: active.withOpacity(.7),
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // rows: List<DataRow>.generate(
            //   15,
            //   (index) => DataRow(
            //     cells: [
            //       DataCell(
            //         CustomText(
            //           text: "Santos Enoque San Francisco",
            //           color: textWhite,
            //         ),
            //       ),
            //       DataCell(CustomText(
            //         text: "New York City",
            //         color: textWhite,
            //       )),
            //       DataCell(
            //         Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(
            //               Icons.star,
            //               color: starTableColor,
            //               size: Dimensions.icon18,
            //             ),
            //             SizedBox(
            //               width: Dimensions.width5,
            //             ),
            //             CustomText(
            //               text: "4.$index",
            //               color: textWhite,
            //             ),
            //           ],
            //         ),
            //       ),
            //       DataCell(
            //         Container(
            //           decoration: BoxDecoration(
            //             border: Border.all(color: active, width: .5),
            //             color: textLiteblue,
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            //           child: CustomText(
            //             text: "Assign ",
            //             color: active.withOpacity(.7),
            //             weight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
