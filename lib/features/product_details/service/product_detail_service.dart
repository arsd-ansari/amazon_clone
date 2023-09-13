// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utild.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsService {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body: jsonEncode({'_id': product.id, 'rating': rating}));
      httpErrorHandle(response: res, context: context, success: () {});
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
