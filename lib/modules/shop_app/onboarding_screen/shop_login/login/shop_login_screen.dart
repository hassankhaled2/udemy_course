import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled13/layout/shop_app/shop_layout.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/cubit/cubit.dart';
import 'package:untitled13/modules/shop_app/onboarding_screen/shop_login/login/cubit/states.dart';
import 'package:untitled13/modules/register/shop_register_screen.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:untitled13/shared/components/constant.dart';
import 'package:untitled13/shared/network/local/cache.helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
             CacheHelper.savedata(key: 'token', value: state.loginModel.data!.token).then((value)
             {
               token=state.loginModel.data!.token;
               navigateAndFinish(context, ShopLayoutScreen());
             });
            }else
            {
              print(state.loginModel.message);
              ShowToast(
                  text:state.loginModel.message!,
                  state:ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state)
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Login now to browse our hot offer',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
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
                          suffix:ShopLoginCubit.get(context).suffix,
                          suffixPressed: 
                              (){
                            ShopLoginCubit.get(context).changepasswordVisibility();
                              },
                          onSubmit: (value)
                          {
                            if(formkey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin
                                (
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          },
                          isPassword: ShopLoginCubit.get(context).isPassword ,
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
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                         condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(function:
                              ()
                          {
                            if(formkey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin
                                (
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          },
                             text:'login',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            defaultTextbutton(function: (){
                              navigateTo(context, ShopRegisterScreen(),);
                            },
                                text:'Register'
                            ),
                          ],
                        )
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
