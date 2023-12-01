import 'package:shopping_app/screens/products/checkout_page.dart';

abstract class Routes {
  Routes._();

  static const HOME = Paths.HOME;
  static const LOGIN = Paths.LOGIN;
  static const REGISTER = Paths.REGISTER;
  static const DETAIL = Paths.DETAIL;
  static const CHECKOUTPAGE = Paths.CHECKOUT;
}

abstract class Paths {
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const REGISTER = '/register';
  static const DETAIL = '/details';
  static const CHECKOUT = '/checkoutPage';
}