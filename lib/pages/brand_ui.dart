// ignore_for_file: must_be_immutable
import 'package:amezon_user/pages/products/product_item.dart';
import 'package:flutter/material.dart';
import '../models/brand_model.dart';

class BrandUiPage extends StatefulWidget {
  BrandUiPage({
    super.key,
    required this.model,
  });

  BrandModel model;

  @override
  State<BrandUiPage> createState() => _BrandUiPageState();
}

class _BrandUiPageState extends State<BrandUiPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsItemPage(
                      model: widget.model,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    constraints: const BoxConstraints(
                        minHeight: 100,
                        maxHeight: 100,
                        minWidth: double.infinity),
                    child: Image(
                      image: NetworkImage(widget.model.thumbnailUrl.toString()),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                width: 120,
                // left: 10,
                child: Center(
                  child: Text(
                    widget.model.brandInfo.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
