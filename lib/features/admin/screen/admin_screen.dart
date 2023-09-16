import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screen/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screen/order_screen.dart';
import 'package:amazon_clone/features/admin/screen/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  final double _width = 42;
  final double _borderwidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrderScreen()
  ];

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          )),
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
                child: const Icon(Icons.analytics_outlined),
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
                child: const Icon(Icons.all_inbox_outlined),
              )),
        ],
      ),
    );
  }
}
