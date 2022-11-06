import 'package:dashboard_feirapp/pages/404/circular.dart';
import 'package:dashboard_feirapp/pages/404/error_page.dart';
import 'package:dashboard_feirapp/pages/productors/productor_form.dart';
import 'package:dashboard_feirapp/pages/splash/splashpage.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:flutter/material.dart';

import '../pages/clients/clients.dart';
import '../pages/productors/productor_page.dart';
import '../pages/overview/overview.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(OverviewPage());
    case productorPageRoute:
      return _getPageRoute(ProductorPage());
    // case productorFormRoute:
    //   return _getPageRoute(ProductorForm());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    case notfoundPageRoute:
      return _getPageRoute(PageNotFound());
    case splashPageRoute:
      return _getPageRoute(SplashPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
