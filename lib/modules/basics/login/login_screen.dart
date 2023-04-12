// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled13/shared/components/components.dart';
class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(

                    label: "Email",
                      controller:emailController,
                    prefix: Icons.email,
                    type:TextInputType.emailAddress,
                    validate:(value)
                    {
                      if(value!.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      label: "Password",
                      controller:passwordController,
                      prefix: Icons.lock,
                      obscureText: !isPassword,
                      suffix: isPassword?Icons.visibility:Icons.visibility_off,
                      isPassword: isPassword,
                      suffixPressed: ()
                      {
                       setState(() {
                         isPassword=!isPassword;
                       });
                      },
                       type:TextInputType.visiblePassword,
                      validate:(value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'password is too short';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      if (formkey.currentState?.validate() != null) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    text: "Login",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                    function: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    text: "Register",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
