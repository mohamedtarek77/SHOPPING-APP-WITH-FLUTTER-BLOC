import '../../models/order.dart';

import 'base_order_repostory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepostory extends BaseOrderRepostory {
  final FirebaseFirestore _firebaseFirestore;
  OrderRepostory({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> orderNow(Order order) {
    // TODO: implement orderNow
    return _firebaseFirestore.collection('Orders').add(order.toDocument());
  }
}
