// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'order_detail.dart';
class OrderCard extends StatefulWidget {
  OrderCard(
      {super.key,
      required this.itemCount,
      required this.data,
      required this.orderId,
      required this.seperateQty});

  int itemCount;
  List<DocumentSnapshot> data;
  String orderId;
  List<String> seperateQty;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetail(orderId: widget.orderId)));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        child: Container(
          color: Colors.transparent,
          // padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount * 90,
          child: ListView.builder(
              itemCount: widget.itemCount,
              itemBuilder: (context, index) {
                ProductModel model = ProductModel.fromJson(
                    widget.data[index].data() as Map<String, dynamic>);
                return placedOrderItem(
                    model, context, int.parse(widget.seperateQty[index]));
              }),
        ),
      ),
    );
  }
}

Widget placedOrderItem(
    ProductModel product, BuildContext context, int productQtyList) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 90,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            product.thumbnailUrl.toString(),
            fit: BoxFit.cover,
            height: 70,
            width: 90,
          ),
        ),
        Flexible(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 6, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    product.proTitle.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.cyan.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '฿${product.price.toString()}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          ' x $productQtyList',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '฿${int.parse(product.price.toString()) * productQtyList}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
