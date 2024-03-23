import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/Home.dart';
import '../views/Result.dart';

class Routes {
  static final routes = [
    GetPage(name: '/Home', page: ()=> Home()),
    GetPage(name: '/Result', page: ()=> Result()),
  ];

}