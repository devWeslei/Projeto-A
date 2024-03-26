import 'package:get/get_navigation/src/routes/get_route.dart';
import '../views/Home.dart';

class Routes {
  static final routes = [
    GetPage(name: '/Home', page: () => Home()),
  ];
}
