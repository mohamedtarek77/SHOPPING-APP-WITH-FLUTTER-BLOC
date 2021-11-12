import '../../../bussiness_logic/blocs/card/card_bloc.dart';
import '../../../bussiness_logic/blocs/catogery/catogery_bloc.dart';
import '../../../bussiness_logic/blocs/order/order_bloc.dart';
import '../../../bussiness_logic/blocs/product/product_bloc.dart';
import '../../../data_layer/repostories/catogery/catogery_repostery.dart';
import '../../../data_layer/repostories/order/order_repostory.dart';
import '../../../data_layer/repostories/product/product_repostery.dart';
import 'home_screen.dart';

import 'package:flutter/foundation.dart';

import 'app_router.dart';

import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(
            productRepostery: ProductRepostery(),
          )..add(Loadproducts()),
        ),
        BlocProvider(
          create: (context) => CardBloc()..add(CardStarted()),
          // child: Container(),
        ),
        BlocProvider(
          create: (_) => CatogeryBloc(catogeryRepostery: CatogeryRepostery())
            ..add(LoadCategories()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
              cardBloc: context.read<CardBloc>(),
              orderRepostory: OrderRepostory()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tarek',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen(),
        onGenerateRoute: AppRouter.onGenarateRouter,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
