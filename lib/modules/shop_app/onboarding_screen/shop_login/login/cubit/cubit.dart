import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/models/user/shop_app/login_model.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/cubit/states.dart';
import 'package:untitled13/shared/network/remote/dio.helper.dart';

import '../../../../../../shared/network/end_point/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel?loginmodel;
  void userLogin({required String email,required String password})
  {
    emit(ShopLoginLoadingState());
 DioHelper.PostData(url:Login , data:{'email':email,'password':password},).then((value)
 {
   print(value?.data);
   loginmodel=ShopLoginModel.fromjson(value?.data);
   print(loginmodel?.status);
   print(loginmodel?.message);
   print(loginmodel?.data?.token);

   emit(ShopLoginSuccessState(loginmodel!));
 }).catchError((error)
 {
   print(error.toString());
   emit(ShopLoginErrorState(error.toString()));
 }
 );}
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;
  void changepasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());

  }
}