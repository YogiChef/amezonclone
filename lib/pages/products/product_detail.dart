// ignore_for_file: must_be_immutable,

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../assistant/cart_methods.dart';
import '../../auth/splash_page.dart';
import '../../carts/cart_page.dart';
import '../../global/global.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({
    super.key,
    required this.model,
  });
  ProductModel model;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int counter = 1;
  deleteProduct() {
    store
        .collection('suppliers')
        .doc(sharedPreferences!.getString('id'))
        .collection('brands')
        .doc(widget.model.brandId)
        .collection('products')
        .doc(widget.model.proId)
        .delete()
        .then((value) =>
            store.collection('products').doc(widget.model.proId).delete());
    Fluttertoast.showToast(msg: 'Product Delited Successfully.');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black87],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 0),
                    stops: [0, 1]))),
        centerTitle: true,
        title: Text(
          widget.model.proTitle.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<CartProvider>(
              builder: (_, count, child) {
                return badges. Badge(
                  position: badges.BadgePosition.topEnd(top: -3,end: 0),
               
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
                    onPressed: () {
                      int itemInCart =
                          Provider.of<CartProvider>(context, listen: false)
                              .count;
                      itemInCart == 0
                          ? Fluttertoast.showToast(
                              msg: 'Cart is empty Please first add to cart.')
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage(
                                        suppId: widget.model.suppId,
                                      )));
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 45,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.pink,
          onPressed: () {
            int itemCount = counter;
            List<String> itemIdList = separateItemIdFromUserCartList();

            itemIdList.contains(widget.model.proId)
                ? Fluttertoast.showToast(msg: 'Item is already in Cart.')
                : addItemToCart(
                    widget.model.proId.toString(), itemCount, context);
          },
          label: const Text(
            'Add to cart',
            style: TextStyle(fontSize: 20),
          ),
          icon: const Icon(Icons.shopping_bag),
        ),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.model.thumbnailUrl.toString(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Text(
              widget.model.proTitle.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Text(
              widget.model.proDescription.toString(),
              textAlign: TextAlign.justify,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Text(
                  '฿${widget.model.price}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 330, left: 10),
            child: Divider(
              thickness: 2,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Cart Is Empty !',
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 36,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 20)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          )
        ],
      ),
    );
  }

  void logInDialog(context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('please log in'),
              content: const Text('you should be logged in to take an action'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Log in'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
