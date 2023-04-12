
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/models/user/shop_app/login_model.dart';
import 'package:untitled13/modules/register/cubit/states.dart';
import 'package:untitled13/shared/network/remote/dio.helper.dart';
import '../../../../../../shared/network/end_point/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel?loginmodel;
  void userRegister({
    required String email,required String password,
    required String name,required String phone
  })
  {
    emit(ShopRegisterLoadingState());
 DioHelper.PostData(url:Register , data:{
   'email':email,
   'password':password,
   'name':name,
   'phone':phone,
 },).then((value)
 {
   print(value?.data);
   loginmodel=ShopLoginModel.fromjson(value?.data);
   print(loginmodel?.status);
   print(loginmodel?.message);
   print(loginmodel?.data?.token);

   emit(ShopRegisterSuccessState(loginmodel!));
 }).catchError((error)
 {
   print(error.toString());
   emit(ShopRegisterErrorState(error.toString()));
 }
 );}
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;
  void changepasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());

  }
}