import 'dart:async';

import '../../../bussiness_logic/blocs/card/card_bloc.dart';
import '../../../data_layer/models/Product.dart';
import 'components/card_product.dart';
import 'components/order_summary.dart';
import '../home_screen/components/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/card';

  //final Product? product;
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => CartScreen(),
        settings: RouteSettings(
          name: routeName,
        ));
  }

  // const CartScreen({Key? key}) : super(key: key);
  bool _isordered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      // backgroundColor: Colors.amber,
      //  items: [],
      // ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                if (state is CardLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CardLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.card.freeDeliveryString),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Text(
                                    "Add more items",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 280,
                              //width: double.infinity,
                              child:

                                  // _isordered == true
                                  // ? SizedBox()
                                  // :

                                  ListView.builder(
                                itemBuilder: (context, index) {
                                  return CardProductCard(
                                    product: state.card
                                        .productQuantity(state.card.products)
                                        .keys
                                        .elementAt(index),
                                    quantity: state.card
                                        .productQuantity(state.card.products)
                                        .values
                                        .elementAt(index),
                                  );
                                },
                                itemCount: state.card
                                    .productQuantity(state.card.products)
                                    .keys
                                    .length,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: OrderSummary()),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                            onPressed: () {
                              //    context.read<CardBloc>().add(CardProductRemoved.);
                              _isordered = true;
                              Navigator.pushNamed(context, '/order');
                            },
                            child: Text('Order Now'))
                      ],
                    ),
                  );
                } else {
                  return Text('some thing went wrong');
                }
              },
            );
          } else {
            return NoInterNetScreen();
          }
        },
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
