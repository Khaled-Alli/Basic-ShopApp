import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/registration/registration_bloc_cubit.dart';
import 'package:shop_app/bloc/registration/registration_bloc_state.dart';
import 'package:shop_app/modules/registration/login_screen.dart';
import 'package:shop_app/shared/constants.dart';

import '../../shared/widgets.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final secondPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  var Form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<RegistrationCubit>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: Form_key,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text("REGISTER",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight
                              .bold),),
                        SizedBox(
                          height: 30,
                        ),
                        Main_Text_Form(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? v) {
                              if (v!.isEmpty) {
                                return "please enter your name";
                              }
                            },
                            label: "Name",
                            prefix: Icon(Icons.person,color: primary_color,)),
                        SizedBox(
                          height: 15,
                        ),
                        Main_Text_Form(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? v) {
                              if (v!.isEmpty || !v.contains("@") ||
                                  !v.contains(".com")) {
                                return "please enter your correct email";
                              }
                            },
                            label: "Email",
                            prefix: Icon(Icons.email,color: primary_color,)),
                        SizedBox(
                          height: 15,
                        ),
                        Main_Text_Form(
                          obscure: cubit.isvisable1,
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? v) {
                              if (v!.isEmpty || v.length < 6) {
                                return "password must be more 6 characters";
                              }
                            },
                            label: "Password",
                            prefix: Icon(Icons.lock,color: primary_color,),
                          suffix: IconButton(
                            onPressed: () {
                              cubit.changeVisability(1);
                            },
                            icon: Icon(cubit.visability1,color: primary_color,),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Main_Text_Form(
                            obscure: cubit.isvisable2,
                            suffix: IconButton(
                              onPressed: () {
                                cubit.changeVisability(2);
                              },
                              icon: Icon(cubit.visability2,color: primary_color,),
                            ),
                            controller: secondPasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? v) {
                              if (v!.isEmpty || v.length < 6) {
                                return "password must be more 6 characters";
                              } else if (secondPasswordController.text !=
                                  passwordController.text) {
                                return "password Dosen\'t match";
                              }
                            },
                            label: "Confirm Password",
                            prefix: Icon(Icons.lock,color: primary_color,)),
                        SizedBox(
                          height: 15,
                        ),
                        Main_Text_Form(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? v) {
                              if (v!.isEmpty) {
                                return "please enter your phone";
                              }
                            },
                            label: "Phone",
                            prefix: Icon(Icons.phone,color: primary_color,)),
                        SizedBox(
                          height: 20,
                        ),
                        Main_Button(function: () {
                          if (Form_key.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );

                          }
                        }, label: "REGISTER"),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I have an account ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigate_to_with_replacement(context: context, screen: LoginScreen());
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16, color: primary_color),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }, listener: (context, state) {
      if (state is UserRegisterSuccessState) {
        if(state.userData.status==true){
          Fluttertoast.showToast(
              msg: "${state.userData.message}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: primary_color,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigate_to_with_replacement(context: context, screen: LoginScreen());
        }else{
          Fluttertoast.showToast(
              msg: "${state.userData.message}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      }

    });
  }
}
