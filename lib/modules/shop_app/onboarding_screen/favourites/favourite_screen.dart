
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/models/user/shop_app/favourite_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../shop_login/cubit/cubit.dart';
import '../shop_login/cubit/states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition:state is! ShopLoadingGetFavouriteState,
          builder:(context)=> ListView.separated(
            itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favouritemodel!.data!.data![index].product!,context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount:ShopCubit.get(context).favouritemodel!.data!.data!.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
