import '../../../../bussiness_logic/blocs/card/card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_layer/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class AddToCart extends StatelessWidget {
  final Product product;

  const AddToCart({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black)
                //border: Border.all(color: product.color),
                ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/add_to_cart.svg',
                color: Colors.black,
                // color: product.color,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/card');
              },
            ),
          ),
          BlocBuilder<CardBloc, CardState>(
            builder: (context1, state) {
              if (state is CardLoading) {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CardLoaded)
                return Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.grey,

                      // color: product.color,
                      onPressed: () {
                        context.read<CardBloc>().add(CardProductAdded(product));
                        Navigator.of(context).pushNamed('/card');
                      },
                      child: Text(
                        'Add To Cart '.toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              else {
                return Text('some thing went wrong');
              }
            },
          )
        ],
      ),
    );
  }
}
