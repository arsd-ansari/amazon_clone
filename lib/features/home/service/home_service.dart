import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utild.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/products?category=$category',
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
              productList.add(Product.fromJson(jsonEncode(p)));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDayProducts(
      {required BuildContext context}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    Product product = Product(
        name: '',
        description: '',
        price: 0,
        quantity: 0,
        category: '',
        images: []);
    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/api/deal-of-day',
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
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return product;
  }
}
