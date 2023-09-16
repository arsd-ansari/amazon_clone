// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utild.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/orders/me',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          success: () {
            for (var p in jsonDecode(res.body)) {
              orderList.add(Order.fromJson(jsonEncode(p)));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return orderList;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
