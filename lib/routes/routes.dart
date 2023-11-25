import 'package:get/get.dart';
import 'package:shopping_app/app_main.dart';
import 'package:shopping_app/screens/login/login_page.dart';
import 'package:shopping_app/screens/login/register_screen.dart';
import 'package:shopping_app/screens/products/home_page.dart';
import 'package:shopping_app/screens/products/product_details.dart';


import 'app_routes.dart';

class Routes{
  static final routes = [
    GetPage(name: Paths.HOME, page: () => HomePage()),
    GetPage(name: Paths.LOGIN, page: () => LoginPage()),
    GetPage(name: Paths.REGISTER, page: () => RegisterScreen()),

    GetPage(name: Paths.DETAIL, page: () => ProductDetails()),
    GetPage(name: '/cart', page: () => AppMain()),
  ];
}