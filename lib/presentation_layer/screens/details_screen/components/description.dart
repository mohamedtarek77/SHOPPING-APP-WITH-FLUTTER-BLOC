import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../data_layer/models/Product.dart';

class Description extends StatelessWidget {
  final Product product;
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),

        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              product.description,
              textStyle: TextStyle(height: 1.5),
              speed: const Duration(microseconds: 60000),
              textAlign: TextAlign.left,
            ),
            //TypewriterAnimatedText('Design first, then code'),
            // TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
            //TypewriterAnimatedText('Do not test bugs out, design them out'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
        //  child: Text(
        //   product.description,
        //   style: TextStyle(height: 1.5),
        // ),
      ),
    );
  }
}
