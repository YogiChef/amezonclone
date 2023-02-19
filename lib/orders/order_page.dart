import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../assistant/cart_methods.dart';
import '../global/global.dart';
import 'order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black87],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 0),
                    stops: [0, 1]))),
        centerTitle: true,
        title: const Text(
          'oRder',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: store
              .collection('users')
              .doc(sharedPreferences!.getString('id'))
              .collection('orders')
              .where('status', isEqualTo: 'normal')
              // .orderBy('orderTime', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snpshot) {
            if (snpshot.hasData) {
              return ListView.builder(
                  itemCount: snpshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: store
                            .collection('products')
                            .where('proId',
                                whereIn: separateOrderItemId(
                                    (snpshot.data!.docs[index].data()
                                        as Map<String, dynamic>)['proId']))
                            .where('orderBy',
                                whereIn: (snpshot.data!.docs[index].data()
                                    as Map<String, dynamic>)['id'])
                            // .orderBy('publishedDate', descending: true)
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return OrderCard(
                                itemCount: snapshot.data!.docs.length,
                                data: snapshot.data!.docs,
                                orderId: snpshot.data!.docs[index].id,
                                seperateQty: separateOrderItemQuantities(
                                    (snpshot.data!.docs[index].data()
                                        as Map<String, dynamic>)['proId']));
                          } else {
                            return const Center(
                              child: Text('No data exists.'),
                            );
                          }
                        });
                  });
            } else {
              return const Center(
                child: Text('No data exists.'),
              );
            }
          }),
    );
  }
}
