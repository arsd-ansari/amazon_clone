import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screen/account_screen.dart';
import 'package:amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  final double _width = 42;
  final double _borderwidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen()
  ];

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatepage,
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: _width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: _borderwidth,
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor))),
                child: const Icon(Icons.home),
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: _width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: _borderwidth,
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor))),
                child: const Icon(Icons.person_outline),
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: _width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: _borderwidth,
                            color: _page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor))),
                child: badge.Badge(
                    badgeStyle:
                        const badge.BadgeStyle(badgeColor: Colors.white),
                    badgeContent: Text('$userCartLength'),
                    child: const Icon(Icons.shopping_cart_checkout_outlined)),
              )),
        ],
      ),
    );
  }
}
