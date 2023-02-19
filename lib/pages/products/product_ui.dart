// ignore_for_file: must_be_immutable
import 'package:amezon_user/pages/products/product_detail.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductUiPage extends StatefulWidget {
  ProductUiPage({
    super.key,
    required this.model,
  });
  ProductModel model;
  @override
  State<ProductUiPage> createState() => _ProductUiPageState();
}

class _ProductUiPageState extends State<ProductUiPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      model: widget.model,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2), topRight: Radius.circular(2)),
                child: Container(
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 250,
                      minWidth: double.infinity),
                  child: Image(
                    image: NetworkImage(widget.model.thumbnailUrl.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: Text(
                        widget.model.proTitle.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      widget.model.price.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Text(
                  widget.model.proDescription.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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
