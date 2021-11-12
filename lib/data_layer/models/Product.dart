import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String image, name, description, id, color, category;
  final int price, size;

  //final Color color;
  const Product(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.description,
      required this.size,
      required this.color,
      required this.category});
  @override
  List<Object?> get props => [
        id,
        image,
        name,
        price,
        description,
        size,
        color,
        category,
      ];
  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        id: snap['id'],
        image: snap['image'],
        name: snap['name'],
        price: snap['price'],
        description: snap['description'],
        size: snap['size'],
        color: snap['color'],
        category: snap['category']);
    return product;
  }

  static List<Product> products = [
    Product(
        id: 'a',
        name: "Office Code",
        price: 10,
        size: 12,
        description: 'dummyText',
        image: '',
        // image: "assets/images/bag_1.png",
        color: '',
        category: ''

        // color: Color(0xFF3D82AE)
        ),
    Product(
        id: '2',
        name: "Belt Bag",
        price: 234,
        size: 8,
        description: 'dummyText',
        image: '',

        // image: "assets/images/bag_2.png",
        color: '',
        category: ''

        // color: Color(0xFFD3A984)
        ),
    Product(
        id: '3',
        name: "Hang Top",
        price: 234,
        size: 10,
        description: 'dummyText',
        image: '',

        // image: "assets/images/bag_3.png",
        color: '',
        category: ''

        // color: Color(0xFF989493)
        ),
    Product(
        id: '4',
        name: "Old Fashion",
        price: 234,
        size: 11,
        description: 'dummyText',
        image: '',

        // image: "assets/images/bag_4.png",
        color: '',
        category: ''

        //  color: Color(0xFFE6B398)
        ),
    Product(
        id: '5',
        name: "Office Code",
        price: 234,
        size: 12,
        description: 'dummyText',
        image: '',

        // image: "assets/images/bag_5.png",
        color: '',
        category: ''

        // color: Color(0xFFFB7883)
        ),
    Product(
        id: '6',
        name: "Office Code",
        price: 234,
        size: 12,
        description: 'dummyText',
        image: '',

        // image: "assets/images/bag_6.png",
        color: '',
        category: ''

        //color: Color(0xFFAEAEAE),
        ),
  ];
//  String dummyText =
  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

}
