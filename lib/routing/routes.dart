const rootRoute = "/";

const overViewPageDisplayName = 'Overview';
const overViewPageRoute = '/overview';

const driversPageDisplayName = 'Drivers';
const driversPageRoute = '/drivers';

const clientsPageDisplayName = 'Clients';
const clientsPageRoute = '/clients';

const authenticationPageDisplayName = 'Authentication';
const authenticationPageRoute = '/authentication';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(overViewPageDisplayName, overViewPageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
