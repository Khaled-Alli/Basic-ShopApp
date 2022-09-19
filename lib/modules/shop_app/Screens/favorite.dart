import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/shared/constants.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubite = BlocProvider.of<ShopCubit>(context);
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is !LoadingGetFavoritState) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: ListView.separated(
                itemBuilder: (context, index) => FavoriteItemBuilder(
                  image: cubite.getFavoriteDataModel!.dataa!.data![index].product!.image,
                  price: cubite.getFavoriteDataModel!.dataa!.data![index].product!.price,
                  oldprice: cubite.getFavoriteDataModel!.dataa!.data![index].product!.oldPrice,
                  name: cubite.getFavoriteDataModel!.dataa!.data![index].product!.name,
                  cubit: cubite,
                    id: cubite.getFavoriteDataModel!.dataa!.data![index].product!.id
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 12,
                ),
                itemCount: cubite.getFavoriteDataModel!.dataa!.data!.length,
              ),
            );
          }else {
            return Center(
              child: CircularProgressIndicator(
                color: primary_color,
              ),
            );
          }

        },
        listener: (context, state) {});
  }

  Widget FavoriteItemBuilder(
      {required image,
      required price,
      required oldprice,
      required name,
        required ShopCubit cubit,required id,
      }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: primary_color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ClipRRect(
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                      height: 120,
                      width: 120,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  if (oldprice != price)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${price}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${oldprice}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      IconButton(
                          color: cubit.favorits![id] !? Colors.red: Colors.grey,

                          onPressed: () {

                            cubit.changeFavorit(id,token);
                          },
                          icon:cubit.favorits![id]!?Icon(Icons.favorite):Icon(Icons.favorite_border_outlined

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
