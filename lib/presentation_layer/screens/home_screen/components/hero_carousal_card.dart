import '../../../../data_layer/models/Product.dart';
import '../../../../data_layer/models/catogery.dart';
import 'package:flutter/material.dart';

class HeroCarousalCard extends StatelessWidget {
  final Category? category;
  final Product? product;

  const HeroCarousalCard({
    Key? key,
    this.category,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.product == null) {}
      },
    );
  }
}
