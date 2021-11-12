import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/Product.dart';
import 'base_product_repostery.dart';

class ProductRepostery extends BaseProductRepostery {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepostery({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshots) {
      return snapshots.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
