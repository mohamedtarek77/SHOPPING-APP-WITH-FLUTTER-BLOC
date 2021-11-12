import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends Equatable {
  final String name;

  const Category({
    required this.name,
  });
  @override
  List<Object?> get props => [name];

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(name: snap['name']);
    return category;
  }
}
