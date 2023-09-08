import 'dart:convert';

import 'package:amazon_clone/constants/utild.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback success,
}) {
  switch (response.statusCode) {
    case 200:
      success();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(context, response.body);
  }
}
