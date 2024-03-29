import 'package:flutter/material.dart';
import 'package:khao/pages/home_page.dart' as home;
import 'package:khao/pages/product_history.dart';
import 'package:khao/pages/scanner.dart' as scan; // Import the Scanner class
import 'package:khao/pages/product_page.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:khao/pages/login.dart';
import 'package:khao/pages/signup.dart';
import 'package:khao/pages/onboarding.dart';
import 'package:khao/pages/upload.dart';
// import 'package:khao/pages/user_info.dart';
import 'package:khao/pages/history.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => home.HomePage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case '/user_info':
      //   return MaterialPageRoute(builder: (_) => UserInfoScreen());
      case '/history':
        return MaterialPageRoute(builder: (_) => History());
      case '/upload':
        return MaterialPageRoute(builder: (_) => ProductUploader());
      case '/product':
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => Myapp2(product: product),
        );
      case '/product_history':
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => Myhistory(data: data),
        );
      case '/scanner': // Add case for the /scanner route
        return MaterialPageRoute(builder: (_) => scan.Scanner());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('No route defined for ${settings.name}'),
            ),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}