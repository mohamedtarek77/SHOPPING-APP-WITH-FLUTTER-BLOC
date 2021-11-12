import '../../../bussiness_logic/blocs/product/product_bloc.dart';
import '../../../data_layer/models/Product.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'components/no_internet_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> allProducts;

  late List<Product> searchedForProducts;

  bool _isSearching = false;
  //bool connected = false;

  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          hintText: 'find a product ....',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          )),
      style: TextStyle(color: Colors.black, fontSize: 18),
      onChanged: (searchedProducts) {
        addSearchedFOrItemsToSearchedList(searchedProducts);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedProducts) {
    searchedForProducts = allProducts
        .where((product) =>
            product.name.toLowerCase().startsWith(searchedProducts))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: Colors.grey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          allProducts = state.products;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            buildCharactersList()
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: GridView.builder(
        itemCount: _searchTextController.text.isEmpty
            ? allProducts.length
            : searchedForProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: kDefaultPaddin,
          crossAxisSpacing: kDefaultPaddin,
          childAspectRatio: .75,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => ItemCard(
          product: _searchTextController.text.isEmpty
              ? allProducts[index]
              : searchedForProducts[index],
          press: () {},
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Products',
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
              ),
            ),
            Image.asset('assets/images/warning.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: buildAppBar(context),
    //  body: Bodyhome(),
    //);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return _isSearching
                  ? BackButton(
                      color: Colors.grey,
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/card');
                        // Get.to(CartScreen());
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/cart.svg',
                        color: kTextColor,
                      ),
                      // By default our  icon color is white
                    );
            } else {
              return Container();
            }
          },
          child: showLoadingIndicator(),
        ),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return NoInterNetScreen();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}

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
        //  Categories(),
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

class ItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.grey,

                // color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: '${product.id}',
                child: product.image.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        // fit: BoxFit.cover,
                        placeholder: 'assets/images/loade.png',
                        image: product.image,
                      )
                    : Image.asset(
                        'assets/images/loade.png',
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.name,
              style: TextStyle(
                  color: kTextLightColor, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '\$${product.price}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: kDefaultPaddin,
          )
        ],
      ),
    );
  }
}

AppBar buildAppBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset(
        "assets/icons/back.svg",
      ),
      onPressed: () {
        //  Navigator.pop(context);
      },
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/search.svg',
          color: kTextColor,
        ),
        // By default our  icon color is white
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/card');
          // Get.to(CartScreen());
        },
        icon: SvgPicture.asset(
          'assets/icons/cart.svg',
          color: kTextColor,
        ),
        // By default our  icon color is white
      ),
      SizedBox(
        width: kDefaultPaddin / 2,
      )
    ],
  );
}
