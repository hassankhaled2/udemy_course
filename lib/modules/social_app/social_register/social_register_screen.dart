import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_screen_layout/social_screen_layout.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formkey =GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state)
        {
          if(state is SocialCreateUserSuccessState) {
          navigateAndFinish(context, SocialLayout());
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
                          'Register now to communicate with friends',
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
                          suffix:SocialRegisterCubit.get(context).suffix,
                          suffixPressed:
                              (){
                           SocialRegisterCubit.get(context).changepasswordVisibility();
                          },
                          onSubmit: (value)
                          {
                            // if(formkey.currentState!.validate())
                            // {
                            //  SocialLoginCubit.get(context).userLogin
                            //     (
                            //       email: emailController.text,
                            //       password: passwordController.text
                            //   );
                            // }

                          },
                          isPassword:SocialRegisterCubit.get(context).isPassword ,
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
                          condition:states is!SocialRegisterLoadingState,
                          builder: (context)=>defaultButton(function:
                              ()
                          {
                            if(formkey.currentState!.validate())
                            {
                             SocialRegisterCubit.get(context).userRegister
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
                        //       navigateTo(context,SocialRegisterScreen(),);
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
