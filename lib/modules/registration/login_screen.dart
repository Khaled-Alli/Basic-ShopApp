import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/registration/registration_bloc_cubit.dart';
import 'package:shop_app/bloc/registration/registration_bloc_state.dart';
import 'package:shop_app/modules/registration/register_screen.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';

import '../../shared/widgets.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  var Form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
        builder: (context, stat) {
      var cubit = BlocProvider.of<RegistrationCubit>(context);
      return Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: Form_key,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "login now to browse our hot offers",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: 80,
                ),
                Main_Text_Form(
                    controller: email_controller,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Email";
                      } else if (!value.contains("@") ||
                          !value.contains(".com")) {
                        return "Please Type Correct Email";
                      }
                    },
                    label: "Email",
                    prefix: Icon(Icons.email,color: primary_color,)),
                SizedBox(
                  height: 15,
                ),
                Main_Text_Form(
                  controller: password_controller,
                  type: TextInputType.visiblePassword,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    } else if (value.length < 6) {
                      return "Password Must be More Than 6 Characters";
                    }
                  },
                  obscure: cubit.isvisable,
                  label: "Password",
                  prefix: Icon(Icons.lock,color: primary_color,),
                  suffix: IconButton(
                    onPressed: () {
                      cubit.changeVisability(0);
                    },
                    icon: Icon(cubit.visability,color: primary_color,),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                stat is UserLoginErrorState
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primary_color,
                        ),
                      )
                    : Main_Button(
                        function: () {
                          if (Form_key.currentState!.validate()) {
                            cubit.userLogin(
                                email: email_controller.text,
                                password: password_controller.text);
                          }
                        },
                        label: "login"),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t have an account ? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigate_to_with_replacement(context: context, screen: RegisterScreen());
                      },
                      child: Text(
                        "REGISTER",
                        style: TextStyle(fontSize: 16, color: primary_color),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
    }, listener: (context, state) {
      if (state is UserLoginSuccessState) {
       if(state.userData.status==true){
         {
           Fluttertoast.showToast(
               msg: "${state.userData.message}",
               toastLength: Toast.LENGTH_LONG,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 5,
               backgroundColor: primary_color,
               textColor: Colors.white,
               fontSize: 16.0
           );
           CachHelper.setStringData(key:"token" , value:state.userData.data!.token ).then((value) {
             Navigate_to_with_replacement(context: context, screen: ShopLayoutScreen());
             token=state.userData.data!.token;
           });
         }
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
