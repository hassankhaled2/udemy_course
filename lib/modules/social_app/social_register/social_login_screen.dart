import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/modules/social_app/social_register/social_register_screen.dart';

import '../../../layout/social_screen_layout/social_screen_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache.helper.dart';
import '../../shop_app/onboarding_screen/search/search.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';




class SocialLoginScreen extends StatelessWidget {
 var formkey =GlobalKey<FormState>();
 var emailController=TextEditingController();
 var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener:(context,state)
        {
          if(state is SocialLoginErrorState)
          {
            ShowToast(text: state.error, state:ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.savedata(
                key: 'uId', value:state.uId ).
            then((value)
            {
              navigateAndFinish(context, SocialLayout());
            });
          }
        } ,
        builder:(context,state)
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
                          'Login now to communicate with friends',
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
                          suffix:SocialLoginCubit.get(context).suffix,
                          suffixPressed:
                              (){
                            SocialLoginCubit.get(context).changepasswordVisibility();
                          },
                          onSubmit: (value)
                          {
                            if(formkey.currentState!.validate())
                            {
                              // SocialLoginCubit.get(context).userLogin
                              //   (
                              //     email: emailController.text,
                              //     password: passwordController.text
                              // );
                            }

                          },
                          isPassword: SocialLoginCubit.get(context).isPassword ,
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
                          condition: state is! SocialLoginLoadingState,
                          builder: (context)=>defaultButton(function:
                              ()
                          {
                            if(formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin
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
                              navigateTo(context, SocialRegisterScreen(),);
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
