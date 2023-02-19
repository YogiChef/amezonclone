// ignore_for_file: must_be_immutable
import 'package:amezon_user/pages/products/product_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../global/global.dart';
import '../../models/brand_model.dart';
import '../../models/product_model.dart';

class ProductsItemPage extends StatefulWidget {
  ProductsItemPage({super.key, required this.model});
  BrandModel model;

  @override
  State<ProductsItemPage> createState() => _ProductsItemPageState();
}

class _ProductsItemPageState extends State<ProductsItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black87],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 0),
                    stops: [0, 1]))),
        centerTitle: true,
        title: Text(
          widget.model.brandInfo.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
              stream: store
                  .collection('suppliers')
                  .doc(widget.model.suppId.toString())
                  .collection('brands')
                  .doc(widget.model.brandId)
                  .collection('products')
                  // .orderBy('publishedDate', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
                if (dataSnapshot.hasData) {
                  return SliverStaggeredGrid.countBuilder(
                      itemCount: dataSnapshot.data!.docs.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemBuilder: (context, index) {
                        ProductModel productModel = ProductModel.fromJson(
                          dataSnapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        );
                        return ProductUiPage(
                          model: productModel,
                        );
                      },
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1));
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No Products Exists'),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
