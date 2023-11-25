abstract class Routes {
  Routes._();

  static const HOME = Paths.HOME;
  static const LOGIN = Paths.LOGIN;
  static const REGISTER = Paths.REGISTER;
  static const DETAIL = Paths.DETAIL;
}

abstract class Paths {
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const REGISTER = '/register';
  static const DETAIL = '/details';
}