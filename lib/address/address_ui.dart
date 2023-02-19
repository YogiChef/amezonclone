// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address_model.dart';
import '../placeorders/place_order.dart';
import '../providers/address_provider.dart';

class AddressUi extends StatefulWidget {
  AddressUi(
      {super.key,
      required this.address,
      required this.index,
      required this.value,
      required this.addressId,
      required this.totolAmount,
      required this.suppId});
  AddressModel address;
  int index;
  int value;
  String addressId;
  double totolAmount;
  String suppId;

  @override
  State<AddressUi> createState() => _AddressUiState();
}

class _AddressUiState extends State<AddressUi> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(
                  value: widget.value,
                  groupValue: widget.index,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    Provider.of<AddressProvider>(context, listen: false)
                        .showSelectedAddress(value);
                  }),
              Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.37),
                    1: FractionColumnWidth(0.63),
                  },
                  children: [
                    TableRow(children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.address.name.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ]),
                    const TableRow(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    TableRow(children: [
                      const Text(
                        'Phone',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.address.phone.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ]),
                    const TableRow(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    TableRow(children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.address.completeAddess.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ]),
                    const TableRow(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.value == Provider.of<AddressProvider>(context).count
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 10)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceOrderPage(
                                    addressId: widget.addressId,
                                    totalAmount: widget.totolAmount,
                                    suppId: widget.suppId,
                                  )));
                    },
                    label: const Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon: const Icon(Icons.skip_next),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
