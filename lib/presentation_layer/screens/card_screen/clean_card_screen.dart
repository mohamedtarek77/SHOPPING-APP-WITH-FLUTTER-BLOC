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

class CleanCartScreen extends StatelessWidget {
  static const String routeName = '/clean';

  //final Product? product;
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => CleanCartScreen(),
        settings: RouteSettings(
          name: routeName,
        ));
  }

  // const CartScreen({Key? key}) : super(key: key);

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
            Navigator.pushNamed(context, '/');
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
                                  return

//
                                      // Dismissible

//
                                      CardProductCard(
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
