import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubite = BlocProvider.of<ShopCubit>(context);
    CategoryModel? categoryModel=cubite.categoryModel;
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(8),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CategoryItemBuilder(
                    image: categoryModel!.data!.data![index]!.image.toString(),
                    name: categoryModel!.data!.data![index]!.name.toString());},
              separatorBuilder: (context, index) =>
                  Container(color: Colors.grey, height: 1),
              itemCount: categoryModel!.data!.data!.length,
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget CategoryItemBuilder({required String image, required String name}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            image,
            height: 80,
            width: 80,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
