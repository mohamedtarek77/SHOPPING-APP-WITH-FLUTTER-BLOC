import '../../../../data_layer/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'package:flutter_svg/svg.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              padding: EdgeInsetsDirectional.all(4),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              // padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.grey,

                // color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: '${product.id}',
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    child: product.image.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/loop.svg',
                            image: product.image,
                          )
                        : SvgPicture.asset(
                            'assets/images/loop.svg',
                          ),

                    //  Image.network(product.image),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.name,
              style: TextStyle(
                  color: kTextLightColor, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '\$${product.price}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: kDefaultPaddin,
          )
        ],
      ),
    );
  }
}
