// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = 'FeirApp';
  static const int APP_VERSION = 1;

  static const String BASE_URL = 'https://api-feiraapp.herokuapp.com/api';

  static const String PRODUCTS_URI = '/produto';
  static const String PRODUCTS_CATEGORY_URI = '/produto/categoria/';
  static const String PROPERTY_URI = '/propriedade';

  static const String INVENTORY_URI = '/estoque';
  static const String INVENTORY_PRODUCT_URI = '/estoque/produto';
  static const String INVENTORY_INFOPRODUCT_URI = '/estoque/infoproduto';

  static const String AUTH_URI = '/login';

  static const String USER_URI = '/usuario';
  static const String USERS_PRODUCTOR_URI = '/Usuario/produtor';

  static const String ORDERS_URI = '/pedido/listar-todos-pedidos';
  static const String ORDERS_OVERVIEW_URI = '/pedido/overview';
  static const String POST_ORDER_URI = '/pedido';
}
