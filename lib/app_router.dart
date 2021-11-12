import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_layer/models/Product.dart';
import 'presentation_layer/screens/card_screen/card_screen.dart';
import 'presentation_layer/screens/card_screen/clean_card_screen.dart';
import 'presentation_layer/screens/details_screen/product_screen.dart';
import 'presentation_layer/screens/done_screen/done_screen.dart';
import 'presentation_layer/screens/home_screen/home_screen.dart';
import 'presentation_layer/screens/order_screen/order_Screen.dart';

class AppRouter {
  static Route onGenarateRouter(RouteSettings settings) {
    print('this is route : ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();

      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);

      case CartScreen.routeName:
        return CartScreen.route();
      case OrderScreen.routeName:
        return OrderScreen.route();

      case CleanCartScreen.routeName:
        return CleanCartScreen.route();

      case DoneScreen.routeName:
        return DoneScreen.route();
      //  case SplashScreen.routeName:
      //   return SplashScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
      ),
    );
  }
}
