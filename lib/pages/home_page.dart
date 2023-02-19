import 'package:amezon_user/pages/supp_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../assistant/cart_methods.dart';
import '../global/global.dart';
import '../models/supp_model.dart';
import '../widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    clearCart(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(), // ME3 147 4644 39
      appBar: AppBar(
        toolbarHeight: 45,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.red],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 0),
                    stops: [0, 1]))),
        centerTitle: true,
        title: const Text(
          'aMazon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              imageSlider(),
              // Positioned(bottom: 0, left: 0, child: keepShoppingProducts()),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: store.collection('suppliers').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    SuppModel model = SuppModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);

                    return SupplierUi(model: model);
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No Data exists.'),
                  ),
                );
              }
            })
      ]),
    );
  }

  imageSlider() {
    return CarouselSlider(
        items: [
          'images/accessories.jpg',
          'images/notebook.jpg',
          'images/computer.png',
          'images/phone.png',
        ].map((img) {
          return Builder(builder: (BuildContext context) {
            return Image.asset(img,
                height: 200, width: double.infinity, fit: BoxFit.cover);
          });
        }).toList(),
        options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            height: MediaQuery.of(context).size.height * .3,
            autoPlay: true));
  }

  keepShoppingProducts() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      alignment: Alignment.topRight,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.white,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.topLeft,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, right: 30, bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'images/amazonpay.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Amazon Pay',
                    style: GoogleFonts.sriracha(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, right: 30, bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'images/recharge.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Recharge',
                    style: GoogleFonts.sriracha(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, right: 30, bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'images/crown.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Rewards',
                    style: GoogleFonts.sriracha(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, right: 30, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'images/paybill.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Pay bill',
                    style: GoogleFonts.sriracha(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),

        // Container(
        //   height: 250,
        //   width: MediaQuery.of(context).size.width,
        //   alignment: Alignment.topLeft,
        //   child: ListView.builder(
        //       shrinkWrap: true,
        //        itemCount: itemLists.length, // > 3 ? 3 : 15,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           height: 250,
        //           width: 250,
        //           color: Colors.white,
        //           margin: const EdgeInsets.only(
        //               left: 0, top: 5, bottom: 5, right: 5),
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(5),
        //                 child: Text(
        //                    itemLists[index].keepshoppingTitle,
        //                   style: GoogleFonts.sriracha(color: Colors.black),
        //                 ),
        //               ),
        //               Container(
        //                 padding: const EdgeInsets.only(top: 5, bottom: 15),
        //                 height: 190,
        //                 child: Image.asset(
        //                   itemLists[index].keepshoppingImage,
        //                 ),
        //               )
        //             ],
        //           ),
        //         );
        //       }),
        // )
      ]),
    );
  }
}
