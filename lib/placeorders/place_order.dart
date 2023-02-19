// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistant/cart_methods.dart';
import '../global/global.dart';
import '../pages/home_page.dart';

class PlaceOrderPage extends StatefulWidget {
  PlaceOrderPage(
      {super.key,
      required this.addressId,
      required this.totalAmount,
      required this.suppId});

  String addressId;
  double totalAmount;
  String suppId;

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  orderDetails() {
    saveOrderUse({
      'addressId': widget.addressId,
      'totalAmount': widget.totalAmount,
      'orderBy': sharedPreferences!.getString('id'),
      'proId': sharedPreferences!.getStringList('userCart'),
      'payment': 'Cash On Delivery',
      'orderTime': orderId,
      'orderId': orderId,
      'isSuccess': true,
      'status': 'normal',
    }).whenComplete(() {
      saveOrderSupp({
        'addressId': widget.addressId,
        'totalAmount': widget.totalAmount,
        'orderBy': sharedPreferences!.getString('id'),
        'proId': sharedPreferences!.getStringList('userCart'),
        'payment': 'Cash On Delivery',
        'orderTime': orderId,
        'orderId': orderId,
        'isSuccess': true,
        'status': 'normal',
      }).whenComplete(() {
        clearCart(context);
        Fluttertoast.showToast(
            msg: 'Congratulations, Order has been placed successfully.');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        orderId = '';
      });
    });
  }

  saveOrderUse(Map<String, dynamic> orderMap) async {
    store
        .collection('users')
        .doc(sharedPreferences!.getString('id'))
        .collection('orders')
        .doc(orderId)
        .set(orderMap);
  }

  saveOrderSupp(Map<String, dynamic> orderMap) async {
    store.collection('orders').doc(orderId).set(orderMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/delivery.webp',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 10)),
              onPressed: () {
                orderDetails();
              },
              icon: const Icon(Icons.gif_box_rounded),
              label: const Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }
}
