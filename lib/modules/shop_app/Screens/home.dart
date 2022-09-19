import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';
import '../../../models/categories_model.dart';
import '../../../shared/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubite = BlocProvider.of<ShopCubit>(context);
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (con, state) {
          if (cubite.homeDataModel != null && cubite.categoryModel != null && cubite.getFavoriteDataModel!=null) {
            return homeDataWidget(cubite.homeDataModel, cubite.categoryModel,context);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: primary_color,
              ),
            );
          }
        },
        listener: (context, state) {});
  }

  Widget homeDataWidget(HomeDataModel? homeData, CategoryModel? categoryModel,  context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
              items: homeData!.data!.banners!
                  .map((e) => Image.network(
                        "${e.image}",
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                viewportFraction: 1,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return categoryBuilder(
                          image: categoryModel!.data!.data![index]!.image
                              .toString(),
                          name: categoryModel!.data!.data![index]!.name
                              .toString());
                    },
                    separatorBuilder: (contex, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: categoryModel!.data!.data!.length,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "New Products",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(homeData.data!.products!.length,
                  (index) => productBilder(homeData.data!.products![index],context)),
              crossAxisSpacing: 2,
              childAspectRatio: 1 / 1.5,
              mainAxisSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryBuilder({required String image, required String name}) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.network(
            image,
            height: 100,
            width: 100,
          ),
          Container(
            width: 100,
            color: Colors.black87,
            child: Text(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ],
      );

  Widget productBilder(Product product,context) {
    var cubite=BlocProvider.of<ShopCubit>(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${product.image}"),
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,
              ),
              if (product.oldPrice != product.price)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "${product.name}",
              style: TextStyle(
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(
                    "${product.price}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primary_color,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                if (product.oldPrice != product.price)
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                      "${product.oldPrice}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                Spacer(),
                IconButton(
                    color: cubite.favorits![product.id] !? Colors.red: Colors.grey,

                    onPressed: () {

                      cubite.changeFavorit(product.id,token);
                    },
                    icon:cubite.favorits![product.id]!?Icon(Icons.favorite):Icon(Icons.favorite_border_outlined

                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
