// ignore_for_file: must_be_immutable

import 'package:amezon_user/address/save_address_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../models/address_model.dart';
import '../providers/address_provider.dart';
import 'address_ui.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key, required this.suppId, required this.totalAmount});
  String suppId;
  double totalAmount;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 45,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black87],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(1, 0),
                    stops: [0, 1]))),
        centerTitle: true,
        title: const Text(
          'iAddress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 10)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveAddressPage(
                              suppId: widget.suppId.toString(),
                              totalAmount: widget.totalAmount.toDouble(),
                            )));
              },
              icon: const Icon(Icons.location_history),
              label: const Text(
                'Add New Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
      ),
      body: Column(
        children: [
          Consumer<AddressProvider>(builder: (context, address, c) {
            return Flexible(
                child: StreamBuilder<QuerySnapshot>(
              stream: store
                  .collection('users')
                  .doc(sharedPreferences!.getString('id'))
                  .collection('userAddress')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async =>
                              await store.runTransaction((transaction) async {
                            DocumentReference docRf = store
                                .collection('users')
                                .doc(sharedPreferences!.getString('id'))
                                .collection('userAddress')
                                .doc(snapshot.data!.docs[index].id);
                            transaction.delete(docRf);
                          }),
                          child: AddressUi(
                            address: AddressModel.formJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>),
                            index: address.count,
                            value: index,
                            addressId: snapshot.data!.docs[index].id,
                            totolAmount: widget.totalAmount,
                            suppId: widget.suppId,
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return const Center(
                    child: Text('No dato exists.'),
                  );
                }
              },
            ));
          })
        ],
      ),
    );
  }
}
