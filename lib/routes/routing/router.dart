import 'package:ecommerce_app/pages/cart.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:flutter/material.dart';

class Router {
  static const String home = '/home';
  static const String login = '/login';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const Home());
      case login:
        //var navigateTo = settings.arguments;
        return MaterialPageRoute(builder: (context) => const Login());
      case cart:
        //var navigateTo = settings.arguments;
        return MaterialPageRoute(builder: (context) => const Cart());
      default:
        return MaterialPageRoute(builder: (context) => const Home());
    }
  }
}
