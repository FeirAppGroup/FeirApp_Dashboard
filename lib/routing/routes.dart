const rootRoute = "/";

const overViewPageDisplayName = 'Overview';
const overViewPageRoute = '/overview';

const productorPageDisplayName = 'Produtor';
const productorPageRoute = '/productor';

const productorFormDisplayName = 'Produtor Form';
const productorFormRoute = '/productor-form';

const clientsPageDisplayName = 'Clients';
const clientsPageRoute = '/clients';

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
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
