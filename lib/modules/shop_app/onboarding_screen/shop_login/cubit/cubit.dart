import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/models/user/shop_app/add_favourites.dart';
import 'package:untitled13/models/user/shop_app/category_model.dart';
import 'package:untitled13/models/user/shop_app/favourite_model.dart';
import 'package:untitled13/models/user/shop_app/login_model.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/categories/categories_screen.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/favourites/favourite_screen.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/products/product_screen.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/setting/setting_screen.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/cubit/states.dart';
import 'package:untitled13/shared/components/constant.dart';
import 'package:untitled13/shared/network/remote/dio.helper.dart';

import '../../../../../models/user/shop_app/home_model1.dart';
import '../../../../../shared/network/end_point/end_point.dart';

class ShopCubit extends Cubit<ShopStates>
{
 ShopCubit():super(ShopInitialState());
 static ShopCubit get(context)=>BlocProvider.of(context);
 int currentIndex=0;
 List<Widget>bottomScreens=
 [
  ProductsScreen(),
  CategoryScreen(),
  FavouriteScreen(),
  SettingScreen(),
 ];
void changeBottom(int index)
{
 currentIndex=index;
 emit(ShopChangeBottomHomeDataState());
}
HomeModel?homemodel;
Map<int,bool>favorites={};
void getHomeData()
{
 emit(ShopLoadingHomeDataState());
 DioHelper.getData(
     url:Home,
    token: token,


 ).then((value)
 {
  homemodel=HomeModel.fromJson(value?.data);
  printFullText(homemodel!.data!.banners.toString());
  print(homemodel?.status);
  homemodel ?.data!.products.forEach((element)
  {
   favorites.addAll(
       {
        element!.Id!:element.InFavourites!
       });
  });
  print(favorites.toString());
  emit(ShopSuccessChangeFavouriteState(changeFavoritesModel!));
 }).catchError((error)
 {
  print(error.toString());
  emit(ShopErrorHomeDataState());
 });
}
 CategoriesModel?categoriesModel;
 void getCategoryData()
 {
  DioHelper.getData(
   url:Get_Categories,
   token:token ,

  ).then((value)
  {
   categoriesModel =CategoriesModel.fromjson(value?.data);
   emit(ShopSuccessCategoriesState());
  }).catchError((error)
  {
   print(error.toString());
   emit(ShopErrorCategoriesState());
  });
 }
 ChangeFavoritesModel?changeFavoritesModel;
void changefavourite(int?productId)
{
 favorites[productId!]=!favorites[productId]!;
 emit( ShopChangeFavouriteState());
 DioHelper.PostData(
  url:favourite,
     data: {
  'product_id':productId,
 },
token: token
 ).then((value)
 {
  changeFavoritesModel=ChangeFavoritesModel.fromjson(value?.data);
  print(value!.data);
  if(!changeFavoritesModel!.status!)
  {
   favorites[productId]=!favorites[productId]!;
  }else
  {
   getFavouriteData();
  }
 emit(ShopSuccessChangeFavouriteState(changeFavoritesModel!));
 }).catchError((error)
 {
  favorites[productId]=!favorites[productId]!;
  emit(ShopErrorChangeFavouritesState());
 });
}
 Favouritesmodel?favouritemodel;
 void getFavouriteData()
 {
  emit(ShopLoadingGetFavouriteState());
  DioHelper.getData(
   url:favourite,
   token:token ,

  ).then((value)
  {
   favouritemodel =Favouritesmodel.fromJson(value?.data);
   printFullText(value!.data.toString());
   emit(ShopSuccessGetFavouriteState());
  }).catchError((error)
  {
   print(error.toString());
   emit(ShopErrorGetFavouriteState());
  });
 }
ShopLoginModel?Usermodel;
 void getUserData()
 {
  emit(ShopLoadingUserDataState());
  DioHelper.getData(
   url:profile,
   token:token ,

  ).then((value)
  {
  Usermodel =ShopLoginModel.fromjson(value?.data);
   printFullText(Usermodel!.data!.name!);
   emit(ShopSuccessUserDataState(Usermodel!));
  }).catchError((error)
  {
   print(error.toString());
   emit(ShopErrorUserDataState());
  });
 }
 void updateUserData({
 required String name,
  required String email,
  required String phone,

})
 {
  emit(ShopSuccessUpdateUserState(Usermodel!));
  DioHelper.PutData(
   url:updateProfile,
   token:token ,
   data: {
    'name':name,
    'email':email,
    'phone':phone,

   },

  ).then((value)
  {
   Usermodel =ShopLoginModel.fromjson(value?.data);
   printFullText(Usermodel!.data!.name!);
   emit(ShopSuccessUpdateUserState(Usermodel!));
  }).catchError((error)
  {
   print(error.toString());
   emit(ShopErrorUpdateUserState());
  });
 }
}