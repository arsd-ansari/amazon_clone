import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utild.dart';
import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      final cloudinary = CloudinaryPublic('dovxvgyia', 'kcfzh8ed');
      List<String> imageUrl = [];
      for (var image in images) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imageUrl.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imageUrl);

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body: product.toJson());

      httpErrorHandle(
          response: res,
          context: context,
          success: () {
            showSnackbar(context, 'Product Add Successfully');

            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> getProducts({required BuildContext context}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
            '$uri/admin/get-products',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onsuccess}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;

    try {
      http.Response res = await http.post(
          Uri.parse('$uri/admin/delete-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body: jsonEncode({
            '_id': product.id,
          }));
      print(res.body);

      httpErrorHandle(response: res, context: context, success: onsuccess);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrder({required BuildContext context}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
            '$uri/admin/get-orders',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
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

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onsuccess}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;

    try {
      http.Response res = await http.post(
          Uri.parse('$uri/admin/change-order-status'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body: jsonEncode({'_id': order.id, 'status': status}));

      httpErrorHandle(response: res, context: context, success: onsuccess);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(
      {required BuildContext context}) async {
    final token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
          Uri.parse(
            '$uri/admin/analytics',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          success: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales('Mobile', response['mobileEarning']),
              Sales('Essentials', response['essentialsEarning']),
              Sales('Appliances', response['appliancesEarning']),
              Sales('Books', response['booksEarning']),
              Sales('Fashion', response['fashionEarning']),
            ];
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return {'sales': sales, 'totalEarning': totalEarning};
  }
}
