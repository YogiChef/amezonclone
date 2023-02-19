// ignore_for_file: must_be_immutable

import 'package:amezon_user/orders/status_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global/global.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({super.key, required this.orderId});

  String orderId;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String status = '';
  @override
  Widget build(BuildContext context) {
    Map orderDataMap;
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: store
            .collection('users')
            .doc(sharedPreferences!.getString('id'))
            .collection('orders')
            .doc(widget.orderId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orderDataMap = snapshot.data!.data() as Map<String, dynamic>;
            status = orderDataMap['status'].toString();
            return Column(
              children: [
                StatusOrder(
                  status: orderDataMap['isSuccess'],
                  orderStatus: status,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '฿ ${orderDataMap['totalAmount'].toString()}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order Id: ${orderDataMap['orderId'].toString()}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Order at: ${DateFormat('dd MM yyyy - hh:mm aa').format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderDataMap['orderTime'])))}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                status == 'ended'
                    ? Center(
                        child: Image.asset(
                        'images/delivery.webp',
                        width: MediaQuery.of(context).size.width * 0.9,
                      ))
                    : Center(child: Image.asset('images/done.webp')),
              ],
            );
          } else {
            return const Center(
              child: Text('No data exists.'),
            );
          }
        },
      )),
    );
  }
}
