import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_service.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_detail_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  AccountService accountService = AccountService();

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  fetchOrders() async {
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {});
  }

  void navigateToOrderDetail(Order order) {
    Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 170,
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          navigateToOrderDetail(orders![index]);
                        },
                        child: SingleProduct(
                          image: orders![index].products[0].images[0],
                        ),
                      );
                    },
                  ))
            ],
          );
  }
}
