import '../../models/catogery.dart';
import 'base_catogery_reposter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatogeryRepostery extends BaseCategoryRepostery {
  final FirebaseFirestore _firebaseFirestore;
  CatogeryRepostery({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
}
