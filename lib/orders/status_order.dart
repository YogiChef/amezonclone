// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class StatusOrder extends StatelessWidget {
  bool status;
  String orderStatus;

  StatusOrder({super.key, required this.status, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? icon;

    status ? icon = Icons.done : icon = Icons.cancel;
    status ? message = "Successful" : message = 'Unsuccess';
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.black87],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1])),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text(
              orderStatus == 'ended'
                  ? 'Parcel Delivered $message'
                  : orderStatus == 'shifted'
                      ? 'Parcel Shifted $message'
                      : orderStatus == 'normal'
                          ? 'Order Placed $message'
                          : '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 12,
              child: Icon(
                Icons.done,
                size: 20,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
