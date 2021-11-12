import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bussiness_logic/blocs/order/order_bloc.dart';
import '../card_screen/components/order_summary.dart';
import '../home_screen/components/no_internet_screen.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderScreen(),
    );
  }

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is OrderLoaded) {
                    return SingleChildScrollView(
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CUSTOMER INFORMATION',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(email: value));
                              },
                              context,
                              'Email',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(fullName: value));
                              },
                              context,
                              'Name',
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'DILEVERY INFORMATION',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(address: value));
                              },
                              context,
                              'Adress',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(city: value));
                              },
                              context,
                              'city',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(country: value));
                              },
                              context,
                              'country',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildTextFormField(
                              (value) {
                                context
                                    .read<OrderBloc>()
                                    .add(UpdataOrder(zipcode: value));
                              },
                              context,
                              'zipCode',
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            OrderSummary(),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                ),
                                onPressed: () {
                                  context
                                      .read<OrderBloc>()
                                      .add(ConfirmedOrder(order: state.order));
                                  if (state is OrderLoaded) {
                                    Navigator.pushNamed(context, '/done');
                                  } else {
                                    Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  //   context.read<CardBloc>().add(CardProductRemoved(product))
                                },
                                child: Text(
                                  'Check Out',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('some thing went wrong');
                  }
                },
              ),
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

  Padding _buildTextFormField(
    //
    Function(String)? onChanged,
    //
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
              child: TextFormField(
            onChanged: onChanged,
            autocorrect: true,
            autofocus: true,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                ))),
          ))
        ],
      ),
    );
  }
}
