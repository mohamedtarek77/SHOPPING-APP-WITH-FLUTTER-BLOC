import '../../../../bussiness_logic/blocs/catogery/catogery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // List<String> categories = ["Hand bag", "Jewellery", "Footwear", "Dresses"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatogeryBloc, CatogeryState>(
      builder: (context, state) {
        if (state is CatogeryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CatogeryLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: SizedBox(
              height: 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                //categories
                itemCount: state.catogeries.length,
                itemBuilder: (context, index) => buildCategory(index),
              ),
            ),
          );
        } else
          return Text('some thing went wrong');
      },
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //    Text(
            //  categories[index],
            //     style: TextStyle(
            //      fontWeight: FontWeight.bold,
            //     color: selectedIndex == index ? kTextColor : kTextLightColor,
            //   ),
            //   ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
