import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/cubit/cubit.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/components/constant.dart';

import '../shop_login/cubit/states.dart';

class SettingScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();
var nameController=TextEditingController();
var phoneController=TextEditingController();
var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener:(context,state)
     {
       // if(state is ShopSuccessUserDataState)
       //   {
       //     print(state.loginModel.data!.name!);
       //     print(state.loginModel.data!.phone!);
       //     print(state.loginModel.data!.email!);
       //     nameController.text=state.loginModel.data!.name!;
       //     phoneController.text=state.loginModel.data!.phone!;
       //     emailController.text=state.loginModel.data!.email!;
       //
       //
       //   }
     },
      builder:(context,state)
      {
        var model=ShopCubit.get(context).Usermodel;
        nameController.text=model!.data!.name!;
        phoneController.text=model.data!.phone!;
        emailController.text=model.data!.email!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).Usermodel!=null,
           builder: (context)=>Padding(
             padding: const EdgeInsets.all(20.0),
             child: Form(
               key: formkey,
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     if(state is ShopLoadingUserDataState)
                       LinearProgressIndicator(),
                     SizedBox(
                       height: 20,
                     ),
                     defaultFormField(
                       controller:nameController,
                       type:TextInputType.name,
                       validate: (String?value)
                       {
                         if(value!.isEmpty)
                         {
                           return 'name must not be empty';
                         }
                         return null;
                       },
                       label: 'Name',
                       prefix: Icons.person,
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     defaultFormField(
                       controller:emailController,
                       type:TextInputType.emailAddress,
                       validate: (String?value)
                       {
                         if(value!.isEmpty)
                         {
                           return 'email must not be empty';
                         }
                         return null;
                       },
                       label: 'Email Address',
                       prefix: Icons.email,
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     defaultFormField(
                       controller:phoneController,
                       type:TextInputType.phone,
                       validate: (String?value)
                       {
                         if(value!.isEmpty)
                         {
                           return 'phone must not be empty';
                         }
                         return null;
                       },
                       label: 'phone',
                       prefix: Icons.phone,
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     defaultButton(function:()
                     {
                       if(formkey.currentState!.validate())
                       {
                         ShopCubit.get(context).updateUserData(name:nameController.text, email:emailController.text, phone: phoneController.text);
                       }

                     }, text:"update"),
                     SizedBox(
                       height: 20,
                     ),
                     defaultButton(function:()
                     {
                       signOut(context);
                     }, text:"LogOut")

                   ],
                 ),
               ),
             ),
           ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
