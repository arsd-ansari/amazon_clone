import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/service/home_service.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeService homeService = HomeService();
  Product? product;
  @override
  void initState() {
    dealOfDay();
    super.initState();
  }

  void dealOfDay() async {
    product = await homeService.fetchDealOfDayProducts(context: context);
    setState(() {});
  }

  void navigateToDeatailScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : GestureDetector(
            onTap: () {
              navigateToDeatailScreen();
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: const Text(
                    'Deal of the Day',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Image.network(
                    product!.images.isNotEmpty
                        ? product!.images[0]
                        : 'https://images.unsplash.com/photo-1682687982183-c2937a74257c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
                    height: 235,
                    fit: BoxFit.fitHeight),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\$${product!.price}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: Text(
                    product!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                          )
                          .toList()
                      //    [
                      //   Image.network(
                      //     'https://images.unsplash.com/photo-1682685796852-aa311b46f50d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
                      //     fit: BoxFit.fitWidth,
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      //   Image.network(
                      //     'https://images.unsplash.com/photo-1682685796852-aa311b46f50d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
                      //     fit: BoxFit.fitWidth,
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      //   Image.network(
                      //     'https://images.unsplash.com/photo-1682685796852-aa311b46f50d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
                      //     fit: BoxFit.fitWidth,
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      //   Image.network(
                      //     'https://images.unsplash.com/photo-1682685796852-aa311b46f50d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
                      //     fit: BoxFit.fitWidth,
                      //     width: 100,
                      //     height: 100,
                      //   )
                      // ],
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15)
                      .copyWith(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'See all deals',
                    style: TextStyle(color: Colors.cyan[800]),
                  ),
                )
              ],
            ),
          );
  }
}
