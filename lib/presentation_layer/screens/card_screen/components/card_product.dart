import '../../../../bussiness_logic/blocs/card/card_bloc.dart';
import '../../../../data_layer/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const CardProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            product.image,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              return Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlineButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      onPressed: () {
                        context
                            .read<CardBloc>()
                            .add(CardProductRemoved(product));
                      },
                      child: Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      quantity.toString().padLeft(2, '0'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlineButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      onPressed: () {
                        context.read<CardBloc>().add(CardProductAdded(product));
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
