import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier {
  double totalAmountOfCartitems = 0;
  double get tAmount => totalAmountOfCartitems;

  showTotalAmount(double totalAmount) async {
    totalAmountOfCartitems = totalAmount;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
