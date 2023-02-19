// ignore_for_file: must_be_immutable

import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/product_model.dart';

class CartItemPage extends StatefulWidget {
  CartItemPage({super.key, required this.model, required this.qty});

  ProductModel model;
  int qty;

  get c => null;

  @override
  State<CartItemPage> createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Card(
        shadowColor: Colors.blueGrey,
        elevation: 10,
        child: SizedBox(
            height: 90,
            width: double.infinity,
            child: Row(
              children: [
                Image.network(
                  widget.model.thumbnailUrl.toString(),
                  width: 100,
                  height: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          widget.model.proTitle.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Row(
                          children: [
                            Text(
                                'Price: ${widget.model.price} x ${widget.qty} ='),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${int.parse(widget.model.price.toString()) * widget.qty}',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CartStepperInt(
                                  value: widget.qty,
                                  didChangeCount: (int value) {
                                    if (value < 1) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'The quantity cannot be less than 1');
                                      Navigator.pop(context);
                                      return;
                                    }
                                    setState(() {
                                      widget.qty = value;
                                    });
                                  },
                                  size: 24,
                                  style: CartStepperTheme.of(context).copyWith(
                                      activeForegroundColor: Colors.red,
                                      activeBackgroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      radius: const Radius.circular(3))),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
