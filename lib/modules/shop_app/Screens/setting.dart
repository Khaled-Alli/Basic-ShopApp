import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext contex) {
    var cubit = BlocProvider.of<ShopCubit>(contex);
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment(0, -.5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: primary_color),
                borderRadius: BorderRadius.circular(15),
              ),
              width: 350,
              height: 250,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      color: primary_color,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/arab.png",
                            ),
                            borderRadius: BorderRadius.circular(150),
                          ), //width: 120,height: 120,
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Container(
                          child: MaterialButton(
                            onPressed: () {
                              cubit.logout(contex);
                             // CachHelper.sharedPreferences!.clear();
                            },
                            child: Text(
                              "LOGOUT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(15),

                            color: Colors.grey[300],
                          ) ,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8,12,8,8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: primary_color,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300],
                            ),
                            width: double.infinity,
                            height: 30,
                            child: Center(
                              child: Text(
                                "${cubit.profileData!.data!.name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: primary_color,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300],
                            ),
                            width: double.infinity,
                            height: 30,
                            child: Center(
                              child: Text(
                                "${cubit.profileData!.data!.email}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Text(
                            "Phone",
                            style: TextStyle(
                                color: primary_color,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300],
                            ),
                            width: double.infinity,
                            height: 30,
                            child: Center(
                              child: Text(
                                "${cubit.profileData!.data!.phone}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
