import '../../../../bussiness_logic/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

import 'item_card.dart';

import 'categorries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bodyhome extends StatelessWidget {
  //late Product product;
  // final VoidCallback pressed;

  Bodyhome();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            'woman',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: .75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                        product: state.products[index], press: () {}

                        // () {
                        //  Navigator.pushNamed(context, '/product', arguments: product);
                        // },
                        ),
                  ),
                );
              } else {
                return Text('some thing went wrong');
              }
            },
          ),
        ),
      ],
    );
  }
}
