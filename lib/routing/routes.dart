import 'package:get/get.dart';

import '../layout.dart';
import '../pages/authentication/authentication.dart';
import '../pages/splash/splashpage.dart';

const rootRoute = "/";

const overViewPageDisplayName = 'Overview';
const overViewPageRoute = '/overview';

const productorPageDisplayName = 'Produtor';
const productorPageRoute = '/productor';

const productorFormDisplayName = 'Produtor Form';
const productorFormRoute = '/productor-form';

const propertyPageDisplayName = 'Propriedades';
const propertyPageRoute = '/property';

const productPageDisplayName = 'Produtos';
const productPageRoute = '/product';

const inventoryPageDisplayName = 'Estoque';
const inventoryPageRoute = '/estoque';

const authenticationPageDisplayName = 'Authentication';
const authenticationPageRoute = '/authentication';

const notfoundPageRoute = '/notfound';
const circularPageRoute = '/circular';
const splashPageRoute = '/splash';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(overViewPageDisplayName, overViewPageRoute),
  MenuItem(productorPageDisplayName, productorPageRoute),
  MenuItem(propertyPageDisplayName, propertyPageRoute),
  MenuItem(productPageDisplayName, productPageRoute),
  MenuItem(inventoryPageDisplayName, inventoryPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

class Routes {
  static List<GetPage> routes = [
    GetPage(name: rootRoute, page: () => SiteLayout()),
    GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
    GetPage(name: splashPageRoute, page: () => SplashPage()),
  ];
}
