import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? brandId;
  String? proId;
  String? proInfo;
  String? proTitle;
  String? proDescription;
  String? price;
  Timestamp? publishedDate;
  String? suppName;
  String? suppId;
  String? status;
  String? thumbnailUrl;

  ProductModel({
    this.brandId,
    this.proId,
    this.proInfo,
    this.proTitle,
    this.proDescription,
    this.price,
    this.publishedDate,
    this.suppName,
    this.suppId,
    this.status,
    this.thumbnailUrl,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    proId = json['proId'];
    proInfo = json['proInfo'];
    proTitle = json['proTitle'];
    proDescription = json['proDescription'];
    price = json['price'];
    publishedDate = json['publishedDate'];
    suppName = json['suppName'];
    suppId = json['suppId'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
