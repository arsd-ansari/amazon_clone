// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/constants/utild.dart';
import 'package:amazon_clone/features/address/service/address_service.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _adresssFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";
  final AddressService addressService = AddressService();
  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    flatController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressService.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressService.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalsum: double.parse(widget.totalAmount));
  }

  void onPressed(String addressFromProvider) async {
    addressToBeUsed = "";
    bool isFrom = flatController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFrom) {
      if (_adresssFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatController.text},${areaController.text},${pincodeController.text} -  ${cityController.text},";
      } else {
        throw Exception('Please Enter all value');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context, 'Error');
    }
    excute();
  }

  void excute() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressService.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressService.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalsum: double.parse(widget.totalAmount));
  }

  @override
  Widget build(BuildContext context) {
    var adrress = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                visible: adrress.isNotEmpty,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Text(
                        adrress,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Form(
                  key: _adresssFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatController,
                        hintText: 'Flat, House No, Building',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area, Street',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'Pincode',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              GooglePayButton(
                margin: const EdgeInsets.only(top: 20),
                type: GooglePayButtonType.buy,
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                paymentConfigurationAsset: 'gpay.json',
                height: 50,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () {
                  onPressed(adrress);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
