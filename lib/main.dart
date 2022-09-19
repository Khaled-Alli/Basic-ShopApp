import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/onboarding/onboarding.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/modules/registration/login_screen.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';
import 'package:shop_app/shared/network/dio.dart';

import 'bloc/registration/registration_bloc_cubit.dart';
import 'bloc/shop/cubite.dart';
import 'modules/registration/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  var onBoarding =await CachHelper.getData(key: "onboarding");
   token =await CachHelper.getData(key:"token");

  runApp(Shop_app(onBoarding));
}

class Shop_app extends StatelessWidget  {
  var onBoarding;

  Shop_app( this.onBoarding);

 starScreen(){
   if(onBoarding != null)
   {
     if(token !=null)
     {
       return ShopLayoutScreen();
     }else
     {
       return LoginScreen();
     }
   }else
   {
     return OnBoarding();
   }
 }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationCubit>(
          create: (BuildContext context) => RegistrationCubit(),

        ),
        BlocProvider<ShopCubit>(
          create: (BuildContext context) {

            return ShopCubit()..getActualData(token: token)..getCategoryData(token)..getFavoriteData(token)..getprofileData(token);

          }
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color:  Color.fromRGBO(108, 99, 255, 1),
              elevation: 0,
            ),
            primaryColor: Color.fromRGBO(108, 99, 255, 1),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(108, 99, 255, 1),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor:  Color.fromRGBO(108, 99, 255, 1),
              selectedItemColor: primary_color,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: starScreen(),

      )
    );




  }
}
