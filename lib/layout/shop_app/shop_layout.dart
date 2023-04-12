import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/search/search.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/shop_login_screen.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/network/local/cache.helper.dart';

import '../../modules/shop_app/onboarding_screen/shop_login/cubit/cubit.dart';
import '../../modules/shop_app/onboarding_screen/shop_login/cubit/states.dart';


class ShopLayoutScreen extends StatelessWidget {
  // @override
  // late Widget form; // Save the form
  //
  // @override
  // Widget Creat(BuildContext context) {
  //   if (form == null) { // Create the form if it does not exist
  //     form = Creat(context); // Build the form
  //   }
  //   return form; // Show the form in the application
  // }
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:Text('Salla'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchShopScreen());
              }, icon:Icon(Icons.search))
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
               cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            //بيعلم على الbutton
            items:
            [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting'
              ),
            ],),
        );

      },
    );
  }
}
