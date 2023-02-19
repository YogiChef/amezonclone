// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import '../models/supp_model.dart';
import 'brand_page.dart';

class SupplierUi extends StatefulWidget {
  SupplierUi({super.key, required this.model});
  SuppModel model;

  @override
  State<SupplierUi> createState() => _SupplierUiState();
}

class _SupplierUiState extends State<SupplierUi> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BrandPage(model: widget.model)));
      },
      child: Card(
        color: Colors.white,
        elevation: 20,
        shadowColor: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.model.name.toString(),
                style: TextStyle(
                    color: Colors.deepOrange.shade800,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.network(
                  widget.model.photoUrl.toString(),
                  height: 118,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SmoothStarRating(
                rating: widget.model.ratings == null
                    ? 0
                    : double.parse(
                        widget.model.ratings.toString(),
                      ),
                // allowHalfRating: true,
                starCount: 5,
                color: Colors.red,
                borderColor: Colors.deepOrange.shade700,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
