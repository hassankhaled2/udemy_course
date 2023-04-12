
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/social_app/social_register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/social_app/social_user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    required String email,required String password,
    required String name,required String phone
  })

  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email, password: password
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.email);
      userCreate(email:email, name: name, phone: phone, uId:value.user!.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error)
    {

      emit(SocialRegisterErrorState(error.toString()));
    });

 }
 void userCreate({
   required String email,
   required String name,required String phone,
   required String uId,
})
 {
   SocialUserModel model=SocialUserModel(
       phone:phone,
       email:email ,
       name:name ,
       uId:uId,
       bio:'write your bio....',
       Cover: "https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?w=1060&t=st=1679357600~exp=1679358200~hmac=e786891d796a026ab8cb90da7f078defec311e598d39d449b0072b8ece46e3d9",
       image: "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1060&t=st=1679350745~exp=1679351345~hmac=ce5eb7ff2eff20d94ac579bb9336e01257e4355ff98d841d0bafee7486b4fe50",
       isEmailVerified: false
   );
 FirebaseFirestore.instance.collection('user').doc(uId).set(
    model.ToMap()).then((value) {
      emit(SocialCreateUserSuccessState());
 }).catchError((error){
   emit(SocialCreateUserErrorState(error.toString()));
 });

 }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;
  void changepasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());

  }
}