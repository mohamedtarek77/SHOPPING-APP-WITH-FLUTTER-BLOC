import '../../../data_layer/models/catogery.dart';
import 'package:flutter/material.dart';

class CatogeryScreen extends StatelessWidget {
  static const String routeName = '/catogery';
  static Route route({required Category category}) {
    return MaterialPageRoute(
        builder: (_) => CatogeryScreen(category: category));
  }

  final Category category;

  const CatogeryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final List<Product> categoryProducts = Product.products
    //  .where((Product) => Product.category == category.name)
    //  .toList();
    return Scaffold(
        // body: Expanded(),
        );
  }
}
