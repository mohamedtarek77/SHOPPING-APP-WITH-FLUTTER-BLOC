import 'dart:ui';

import '../../../bussiness_logic/blocs/card/card_bloc.dart';
import '../home_screen/components/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_offline/flutter_offline.dart';

class DoneScreen extends StatelessWidget {
  static const String routeName = '/done';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DoneScreen(),
    );
  }

  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Timer(Duration(seconds: 5), () {
    //  Navigator.pushNamed(context, '/');
    // });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon: SvgPicture.asset('assets/icons/back.svg'),
            color: Colors.black,
          ),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'Your order has been successfully received , clean your shopping card now please ',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/clean');
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/empty.png'),
                  SizedBox(
                    height: 1,
                  )
                ],
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
        ));
  }
}
