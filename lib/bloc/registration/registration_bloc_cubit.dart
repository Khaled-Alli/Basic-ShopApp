import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/bloc/registration/registration_bloc_state.dart';
import 'package:shop_app/models/userdata_model.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(InitialRegistrationState());
  IconData visability1 = Icons.visibility_outlined;
  IconData visability2 = Icons.visibility_outlined;
  IconData visability = Icons.visibility_outlined;
  bool isvisable1 = false;
  bool isvisable2 = false;
  bool isvisable = false;
  UserDataModel? logUserData;
  SharedPreferences? sharedPreferences;
  void changeVisability(int x) {
   if(x==1){
     if (isvisable1) {
       isvisable1 = !isvisable1;
       visability1 =Icons.visibility_outlined ;
     } else {
       isvisable1 = !isvisable1;
       visability1 =Icons.visibility_off_outlined ;
     }
   }else if(x==2){
     if (isvisable2) {
       isvisable2 = !isvisable2;
       visability2 =Icons.visibility_outlined ;
     } else {
       isvisable2 = !isvisable2;
       visability2 =Icons.visibility_off_outlined ;
     }
   }else{
     if (isvisable) {
       isvisable = !isvisable;
       visability =Icons.visibility_outlined ;
     } else {
       isvisable = !isvisable;
       visability =Icons.visibility_off_outlined ;
     }
   }
    emit(ChangeVisabilityState());
  }

  void userLogin({required email, required password}) {
    emit(UserLoginLoadingState());
    DioHelper.postData(url: "login", data: {
      "email": email,
      "password": password,
    }).then((value) {
      logUserData=UserDataModel.fromJson(value.data);
      emit(UserLoginSuccessState(logUserData!));
    }).catchError((e){
      emit(UserLoginErrorState(e.toString()));
    });
  }
  UserDataModel? regUserData;
  void userRegister({required name,required email, required password,required phone}){
    emit(UserRegisterLoadingState());
    DioHelper.postData(url: "register", data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) {
      regUserData=UserDataModel.fromJson(value.data);
      emit(UserRegisterSuccessState(regUserData!));
    }).catchError((e){
      emit(UserRegisterErrorState(e.toString()));
    });
  }


}
