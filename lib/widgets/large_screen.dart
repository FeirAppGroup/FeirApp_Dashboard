import 'package:flutter/material.dart';

import '../helpers/local_navigator.dart';
import 'Menu_Item/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideMenu(),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        ),
      ],
    );
  }
}
