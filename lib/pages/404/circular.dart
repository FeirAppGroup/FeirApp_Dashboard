import 'package:after_layout/after_layout.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dtos/user_login_dto.dart';

class CircularPage extends StatefulWidget {
  const CircularPage({Key? key}) : super(key: key);

  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
