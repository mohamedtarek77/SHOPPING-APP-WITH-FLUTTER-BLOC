import '../home_screen/components/no_internet_screen.dart';

import '../../../data_layer/models/Product.dart';

import '../../../constants.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_offline/flutter_offline.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProductScreen(
        product: product,
      ),
    );
  }

  final Product product;

  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      //  backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Body(product: product);
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,

      // backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        //  IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset('assets/icons/search.svg'),
        //   )
        // ,
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/card');
          },
          icon: SvgPicture.asset('assets/icons/cart.svg'),
        ),
        SizedBox(
          width: kDefaultPaddin / 2,
        )
      ],
    );
  }
}
