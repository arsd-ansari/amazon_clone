import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AddProductScreen());
    case CategoryDealScreen.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => CategoryDealScreen(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = settings.arguments as String;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailsScreen.routeName:
      var product = settings.arguments as Product;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    default:
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Wrong Route'),
                ),
              ));
  }
}
