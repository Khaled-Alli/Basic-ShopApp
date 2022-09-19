import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/shop/cubite.dart';
import 'package:shop_app/bloc/shop/state.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/widgets.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ShopCubit>(context);
    var key = GlobalKey<FormState>();
    var controller = TextEditingController();
   return BlocConsumer<ShopCubit,ShopState>(builder: (context,state){

     return Scaffold(
       appBar: AppBar(backgroundColor: Color.fromRGBO(250, 250, 250, 1),
         leading: IconButton(
           icon: Icon(Icons.arrow_back_outlined, color: primary_color,),
           onPressed: () {
             Navigator.of(context).pop();
           },
         ),),
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           children: [
             Container(
               child:Form(
                 key: key,
                 child: Main_Text_Form(controller: controller,
                     type: TextInputType.text,
                     validate: (String? v) {
                       if (v!.isEmpty) {
                         return "Search field must be not empty";
                       }
                       else
                         return null;
                     },
                     label: "Search",
                     prefix: Icon(Icons.search, color: primary_color,),
                     onsubmit: (String? value) {
                       cubit.search(text: value);
                     }
                 ),
               ),
             ),
             SizedBox(height: 20,),
             if(state is SuccessSearchState)
             Expanded(
               child: ListView.separated(
                 itemBuilder: (context, index) {
                   return SearchItemBuilder(
                     image: cubit.searchModel!.dataa!.data![index]!.image.toString(),
                     price: cubit.searchModel!.dataa!.data![index]!.price.toString(),
                     name: cubit.searchModel!.dataa!.data![index]!.name.toString(),
                     cubit: cubit,
                     id: cubit.searchModel!.dataa!.data![index]!.id,);},

                 separatorBuilder: (context, index) =>
                    SizedBox( height: 15),
                 itemCount:cubit.searchModel!.dataa!.data!.length,
               ),
             ),
             // if(state is !SuccessSearchState)
             //   Center(child: CircularProgressIndicator(color: primary_color,),)
           ],
         ),
       )
       ,
     );

   },
       listener: (context,state){});
  }

  Widget SearchItemBuilder({required image,
    required price,
    required name,
    required ShopCubit cubit,
    required id,
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
                      Spacer(),
                      IconButton(
                          color: cubit.favorits![id] ! ? Colors.red : Colors
                              .grey,

                          onPressed: () {
                            cubit.changeFavorit(id, token);
                          },
                          icon: cubit.favorits![id]!
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border_outlined

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
