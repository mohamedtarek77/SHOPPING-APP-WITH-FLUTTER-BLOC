import '../../../../data_layer/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ColorAndSize extends StatelessWidget {
  final Product product;

  const ColorAndSize({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Size',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              )
              // Text('color'),
              //   Row(
              //    children: <Widget>[
              //    ColorDot(
              //      color: Color(0xFF356C95),
              //     isSelected: true,
              //   ),
//                  ColorDot(color: Color(0xFFF8C078)),
              //      ColorDot(color: Color(0xFFA29B9B)),
              //      ],
              //    )
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                // TextSpan(text: 'size\n', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: '${product.size}cm',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);
  final Color color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPaddin / 4,
        right: kDefaultPaddin / 2,
      ),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? color : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
