import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/registration/login_screen.dart';
import 'package:shop_app/modules/shop_app/Screens/category.dart';
import 'package:shop_app/modules/shop_app/Screens/home.dart';
import 'package:shop_app/modules/shop_app/Screens/search.dart';
import 'package:shop_app/modules/shop_app/Screens/setting.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';
import 'package:shop_app/shared/network/dio.dart';

import '../../models/get_favorite_model.dart';
import '../../models/search_model.dart';
import '../../models/userdata_model.dart';
import '../../modules/shop_app/Screens/favorite.dart';
import '../../shared/widgets.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialState());

  var cuerrentIndex = 0;
  List BottomNavPage = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  List BottomNavPageTitle = [
    "Home",
    "Categories",
    "Favorites",
    "Settings",
  ];

  void changeBottomNavBar(index) {
    cuerrentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  //HomeData? homeData;

  HomeDataModel? homeDataModel;
  Map<dynamic,dynamic>? favorits = {};

  void getActualData({required token}) {
    emit(LoadingGetDateState());
    DioHelper.getData(
      url: "home",
      token: token,
    ).then((value) {
      homeDataModel = HomeDataModel.fromJson(value.data);
      homeDataModel!.data!.products!.forEach((element) {
        favorits![element.id!] = element.inFavorites!;

      });
    }).then((value) {
      if (homeDataModel != null) emit(SuccessGetDateState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetDateState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData(token) {
    emit(LoadingCategoriesState());
    DioHelper.getData(url: "categories", token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
    }).then((value) {
      if (categoryModel != null) emit(SuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCategoriesState());
    });
  }

  FavoriteModel? favoriteModel;
  void changeFavorit(product_ID, token) {

    emit(LoadingGetFavoritState());

    favorits![product_ID]=!favorits![product_ID];
    emit(SuccessChsngeFavoritsState());
    DioHelper.postData(
            url: "favorites", data: {"product_id": product_ID}, token: token)
        .then((value) {
          favoriteModel=FavoriteModel.fromJson(value.data);

          if(!favoriteModel!.status!){
            favorits![product_ID]=!favorits![product_ID];
            Fluttertoast.showToast(
                msg: "${favoriteModel!.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: primary_color,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else{
            getFavoriteData(token);
          }
          emit(SuccessChsngeFavoritState());


    }).catchError((e) {
      print(e.toString());
      favorits![product_ID]=!favorits![product_ID];
      emit(ErrorChsngeFavoritState());
    });
  }

  GetFavoriteDataModel? getFavoriteDataModel;

  void getFavoriteData(token) {
    DioHelper.getData(url: "favorites", token: token).then((value) {
      getFavoriteDataModel = GetFavoriteDataModel.fromJson(value.data);

    }).then((value) {
        emit(SuccessGetFavoritState());

    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFavoritState());
    });
  }

  UserDataModel? profileData;
  void getprofileData(token) {
    print("profileData!.data!.name.toString()");
    DioHelper.getData(url: "profile", token: token).then((value) {
      profileData = UserDataModel.fromJson(value.data);
    }).then((value) {
      print(profileData!.data!.name.toString());
     emit(SuccessGetprofileDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetprofileDataState());
    });
  }

  void logout(context){
    CachHelper.removeData(key: "token").then((value) {Navigate_to_with_replacement(context: context, screen: LoginScreen());
    cuerrentIndex=0;
    } );
  }

//products/search
  SearchModel? searchModel;
void search({required text}){
  print("object");
  DioHelper.postData(url:"products/search", token: token , data: {"text":text}).then((value) {
    searchModel=SearchModel.fromJson(value.data);
    print(searchModel!.dataa!.data![0].name);
    emit(SuccessSearchState());
  }).catchError((e){
    print(e.toString());
    emit(ErrorSearchState());
  });
}

}
