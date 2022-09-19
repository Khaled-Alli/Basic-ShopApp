import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/modules/shop_app/Screens/search.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';
import '../../../shared/constants.dart';
import '../../../shared/widgets.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubite = BlocProvider.of<ShopCubit>(context);
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            cubite.BottomNavPageTitle[cubite.cuerrentIndex],
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            IconButton(onPressed: (){
              Navigate_to(context: context, screen: SearchScreen());
            }, icon: Icon(Icons.search)),
          ],
          backgroundColor: primary_color,
        ),
        body: cubite.BottomNavPage[cubite.cuerrentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubite.cuerrentIndex,
            backgroundColor: Color.fromRGBO(108, 99, 255, 1),
            selectedItemColor: primary_color,
            unselectedItemColor: Colors.grey[600],
            onTap: (index) {
              cubite.changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "settings",
              ),
            ]),
      ),
      listener: (context, state) {},
    );
  }
}
