import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/register/cubit/cubit.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/cubit/cubit.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/cubit/states.dart';

import '../../layout/shop_app/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache.helper.dart';
import '../shop_app/onboarding_screen/shop_login/login/cubit/cubit.dart';
import '../shop_app/onboarding_screen/shop_login/login/cubit/states.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formkey =GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
       listener: (context,states)
       {
         if(states is ShopRegisterSuccessState)
         {
           if(states.loginModel.status!)
           {
             print(states.loginModel.message);
             print(states.loginModel.data?.token);
             CacheHelper.savedata(key: 'token', value: states.loginModel.data!.token).then((value)
             {
               token=states.loginModel.data!.token;
               navigateAndFinish(context, ShopLayoutScreen());
             });
           }else
           {
             print(states.loginModel.message);
             ShowToast(
               text:states.loginModel.message!,
               state:ToastStates.ERROR,
             );
           }
         }
       },
        builder: (context,states)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to browse our hot offer',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30,
                        ),
                        defaultFormField(
                          type:TextInputType.name,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "please enter yourname";
                            }

                          },
                          label: 'name',
                          prefix: Icons.person,
                          controller:nameController,

                        ),
                        SizedBox(height: 30,
                        ),
                        defaultFormField(
                          type:TextInputType.emailAddress,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "please enter your email address";
                            }

                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          controller:emailController,

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          type:TextInputType.visiblePassword,
                          suffix:ShopRegisterCubit.get(context).suffix,
                          suffixPressed:
                              (){
                            ShopRegisterCubit.get(context).changepasswordVisibility();
                          },
                          onSubmit: (value)
                          {
                            // if(formkey.currentState!.validate())
                            // {
                            //   ShopLoginCubit.get(context).userLogin
                            //     (
                            //       email: emailController.text,
                            //       password: passwordController.text
                            //   );
                            // }

                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword ,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Password is too short";
                            }

                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          controller:passwordController,

                        ),
                        SizedBox(height: 30,
                        ),
                        defaultFormField(
                          type:TextInputType.phone,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "please enter your phone";
                            }

                          },
                          label: 'phone',
                          prefix: Icons.phone,
                          controller:phoneController,

                        ),

                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition:states is! ShopRegisterLoadingState,
                          builder: (context)=>defaultButton(function:
                              ()
                          {
                            if(formkey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister
                                (
                                  email: emailController.text,
                                  password: passwordController.text,
                                name:nameController.text,
                                phone: phoneController.text,

                              );
                            }

                          },
                            text:'Register',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Don't have an account?"),
                        //     defaultTextbutton(function: (){
                        //       navigateTo(context, ShopRegisterScreen(),);
                        //     },
                        //         text:'Register'
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
