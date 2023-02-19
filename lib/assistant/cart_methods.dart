// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../providers/cart_provider.dart';

void addItemToCart(String proId, int counter, BuildContext context) {
  List<String>? tempList = sharedPreferences!.getStringList('userCart');
  tempList!.add(proId.toString() + ':'+ counter.toString()); // ******

  store.collection('users').doc(sharedPreferences!.getString('id')).update({
    'userCart': tempList,
  }).then((value) {
    Fluttertoast.showToast(msg: "Item addred successfully.");
    sharedPreferences!.setStringList('userCart', tempList);

    Provider.of<CartProvider>(context, listen: false).showCartList();
  });
}

void clearCart(BuildContext context) {
  sharedPreferences!.setStringList('userCart', ['initialValue']);
  List<String>? emptyCartList = sharedPreferences!.getStringList('userCart');

  store.collection('users').doc(sharedPreferences!.getString('id')).update({
    'userCart': emptyCartList,
  }).then((value) {
    Provider.of<CartProvider>(context, listen: false).showCartList();
  });
}

separateItemIdFromUserCartList() {
  List<String>? userCartList = sharedPreferences!.getStringList('userCart');

  List<String> itemsIdList = [];
  for (int i = 1; i < userCartList!.length; i++) {
    String item = userCartList[i].toString();
    var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(':');
    String getItemId =
        item.substring(0, lastCharacterPositionOfItemBeforeColon);
    itemsIdList.add(getItemId);
  }
  return itemsIdList;
}

separateItemQuantitiesFromUserCartList() {
  List<String>? userCartList = sharedPreferences!.getStringList('userCart');

  List<int> itemsQuantitiesList = [];
  for (int i = 1; i < userCartList!.length; i++) {
    String item = userCartList[i].toString();
    var colonAndAfterCharactersList = item.split(':').toList();
    var qty = int.parse(colonAndAfterCharactersList[1].toString());

    itemsQuantitiesList.add(qty);
  }

  return itemsQuantitiesList;
}

separateOrderItemId(proId) {
  List<String>? userCartList = List<String>.from(proId);

  List<String> itemsIdList = [];
  for (int i = 1; i < userCartList.length; i++) {
    String item = userCartList[i].toString();
    var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(':');
    String getItemId =
        item.substring(0, lastCharacterPositionOfItemBeforeColon);
    itemsIdList.add(getItemId);
  }
  return itemsIdList;
}

separateOrderItemQuantities(proId) {
  List<String>? userCartList = List<String>.from(proId);

  List<String> itemsQuantitiesList = [];
  for (int i = 1; i < userCartList.length; i++) {
    String item = userCartList[i].toString();
    var colonAndAfterCharactersList = item.split(':').toList();
    var qty = int.parse(colonAndAfterCharactersList[1].toString());

    itemsQuantitiesList.add(qty.toString());
  }

  return itemsQuantitiesList;
}
