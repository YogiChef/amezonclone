// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/textfield.dart';

class SaveAddressPage extends StatefulWidget {
  SaveAddressPage({super.key, required this.suppId, required this.totalAmount});
  String suppId;
  double totalAmount;

  @override
  State<SaveAddressPage> createState() => _SaveAddressPageState();
}

class _SaveAddressPageState extends State<SaveAddressPage> {
  final nameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final streetCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final districtCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final countryCtr = TextEditingController();
  final zipcodeCtr = TextEditingController();

  String completeAddress = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          'saveAddress',
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
                saveAddress();
              },
              icon: const Icon(Icons.save),
              label: const Text(
                'Save Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black12, Colors.deepOrange.shade200],
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(1, 0),
              stops: const [0, 1]),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              InputTextField(
                controller: nameCtr,
                icon: Icons.account_box,
                keyboardType: TextInputType.text,
                hintText: 'Name',
              ),
              InputTextField(
                maxlength: 10,
                controller: phoneCtr,
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                hintText: 'Phone',
              ),
              InputTextField(
                controller: streetCtr,
                icon: Icons.signpost,
                keyboardType: TextInputType.text,
                hintText: 'Street',
              ),
              InputTextField(
                controller: addressCtr,
                icon: Icons.home_filled,
                keyboardType: TextInputType.text,
                hintText: 'Home Address',
              ),
              InputTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your District';
                  } else {
                    return null;
                  }
                },
                controller: districtCtr,
                icon: Icons.villa_outlined,
                keyboardType: TextInputType.text,
                hintText: 'District',
              ),
              InputTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your City';
                  } else {
                    return null;
                  }
                },
                controller: cityCtr,
                icon: Icons.location_city_outlined,
                keyboardType: TextInputType.text,
                hintText: 'City',
              ),
              InputTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Country';
                  } else {
                    return null;
                  }
                },
                controller: countryCtr,
                icon: Icons.flag_circle,
                keyboardType: TextInputType.text,
                hintText: 'Country',
              ),
              InputTextField(
                maxlength: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Country';
                  } else {
                    return null;
                  }
                },
                controller: zipcodeCtr,
                icon: Icons.pin,
                keyboardType: TextInputType.number,
                hintText: 'Zipcode',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveAddress() {
    if (_formKey.currentState!.validate()) {
      completeAddress =
          '${streetCtr.text.trim()}, ${addressCtr.text.trim()},\n ${districtCtr.text.trim()}, ${cityCtr.text.trim()}, ${countryCtr.text.trim()},\n ${zipcodeCtr.text.trim()}.';
      store
          .collection('users')
          .doc(sharedPreferences!.getString('id'))
          .collection('userAddress')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        'name': nameCtr.text.trim(),
        'phone': phoneCtr.text.trim(),
        'street': streetCtr.text.trim(),
        'homeaddress': addressCtr.text.trim(),
        'district': districtCtr.text.trim(),
        'city': cityCtr.text.trim(),
        'country': countryCtr.text.trim(),
        'zipcode': zipcodeCtr.text.trim(),
        'completeAddess': completeAddress,
      }).then(
        (value) {
          Fluttertoast.showToast(msg: 'New Shipment Address has been saved.');
          _formKey.currentState!.reset();
          Navigator.pop(context);
        },
      );
    }
  }
}
