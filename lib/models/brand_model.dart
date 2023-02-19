import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String? brandId;
  String? brandInfo;
  String? brandTitle;
  Timestamp? publishedDate;
  String? suppId;
  String? status;
  String? thumbnailUrl;

  BrandModel({
    this.brandId,
    this.brandInfo,
    this.brandTitle,
    this.publishedDate,
    this.suppId,
    this.status,
    this.thumbnailUrl,
  });

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    brandInfo = json['brandInfo'];
    brandTitle = json['brandTitle'];
    publishedDate = json['publishedDate'];
    suppId = json['suppId'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
   
  }
}
