import 'package:flutter/cupertino.dart';

import '../global/global.dart';

class CartProvider extends ChangeNotifier {
  int cartList = sharedPreferences!.getStringList('userCart')!.length - 1;

  int get count => cartList;

  Future<void> showCartList() async {
    cartList = sharedPreferences!.getStringList('userCart')!.length - 1;
    await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
