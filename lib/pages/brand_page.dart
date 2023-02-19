// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../global/global.dart';
import '../models/brand_model.dart';
import '../models/supp_model.dart';
import 'brand_ui.dart';

class BrandPage extends StatefulWidget {
  BrandPage({super.key, required this.model});
  SuppModel model;

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black87],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(1, 0),
                      stops: [0, 1]))),
          centerTitle: true,
          title: Text(
            widget.model.name.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: CustomScrollView(
          slivers: [
            StreamBuilder<QuerySnapshot>(
                stream: store
                    .collection('suppliers')
                    .doc(widget.model.id.toString())
                    .collection('brands')
                    // .orderBy('publishedDate', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
                  if (dataSnapshot.hasData) {
                    return SliverStaggeredGrid.countBuilder(
                        itemCount: dataSnapshot.data!.docs.length,
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        itemBuilder: (context, index) {
                          BrandModel brandModel = BrandModel.fromJson(
                            dataSnapshot.data!.docs[index].data()
                                as Map<String, dynamic>,
                          );
                          return BrandUiPage(
                            model: brandModel,
                          );
                        },
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1));
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No brands Exists'),
                      ),
                    );
                  }
                }),
          ],
        ));
  }
}
