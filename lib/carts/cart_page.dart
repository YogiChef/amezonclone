// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../address/address_page.dart';
import '../assistant/cart_methods.dart';
import '../global/global.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/total_amount.dart';
import 'cart_item_page.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key, this.suppId});
  String? suppId;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> itemQtyList = [];
  double totalAmount = 0;

  @override
  void initState() {
    itemQtyList = separateItemQuantitiesFromUserCartList();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).showTotalAmount(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 40,
      //   title: const Text(
      //     'iCart',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.w800,
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20),
      //       child: Consumer<CartProvider>(
      //         builder: (_, count, child) {
      //           return Badge(
      //             toAnimate: false,
      //             shape: BadgeShape.circle,
      //             borderRadius: BorderRadius.circular(8),
      //             position: const BadgePosition(top: -3, end: -3),
      //             badgeContent: Center(
      //               child: Text(
      //                 count.count.toString(),
      //                 style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.w700),
      //               ),
      //             ),
      //             child: IconButton(
      //               onPressed: () {},
      //               icon: const Icon(
      //                 Icons.shopping_cart,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //             colors: [Colors.black, Colors.black87],
      //             begin: FractionalOffset(0, 0),
      //             end: FractionalOffset(1, 0),
      //             stops: [0, 1])),
      //   ),
      //   centerTitle: true,
      // ),
      floatingActionButton: SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              heroTag: '1',
              backgroundColor: Colors.black,
              onPressed: () {},
              label: const Text(
                'Clear Cart',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              icon: const Icon(Icons.delete_outline),
            ),
            FloatingActionButton.extended(
              heroTag: '2',
              backgroundColor: Colors.pink,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressPage(
                              suppId: widget.suppId.toString(),
                              totalAmount: totalAmount.toDouble(),
                            )));
              },
              label: const Text(
                'Check Out',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              icon: const Icon(Icons.check),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                child: Consumer2<TotalAmount, CartProvider>(
                    builder: ((context, total, cart, child) {
                  if (cart.count == 0) {
                    return Container();
                  } else {
                    return Container(
                      height: 110,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black87],
                              begin: FractionalOffset(0, 0),
                              end: FractionalOffset(1, 0),
                              stops: [0, 1])),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 23, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                const Text(
                                  'iCart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Consumer<CartProvider>(
                                  builder: (_, count, child) {
                                    return badges.Badge(
                                     
                                      badgeContent: Center(
                                        child: Text(
                                          count.count.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Total: ฿${total.tAmount}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }
                })),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: store
                  .collection('products')
                  .where('proId', whereIn: separateItemIdFromUserCartList())
                  .orderBy('publishedDate', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      ProductModel model = ProductModel.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);

                      if (index == 0) {
                        totalAmount = 0.0;
                        totalAmount = totalAmount +
                            (double.parse(model.price!) * itemQtyList[index]);
                      } else {
                        totalAmount = totalAmount +
                            (double.parse(model.price!) * itemQtyList[index]);
                      }
                      if (snapshot.data!.docs.length - 1 == index) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Provider.of<TotalAmount>(context, listen: false)
                              .showTotalAmount(totalAmount);
                        });
                      }
                      return CartItemPage(
                          model: model, qty: itemQtyList[index]);
                    }, childCount: snapshot.data!.docs.length),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No Item exists in cart'),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
