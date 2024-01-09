// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';
import 'package:shop_app_flutter/shared/styles/size.dart';

import '../../shared/styles/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen(
      {Key? key,
         required this.productName,
         required this.productDiscount,
         required this.productId,
         required this.productOldPrice,
         required this.productPrice,
         required this.productDescription,
        required this.productImage,
      })
      : super(key: key);

  String productName;
  String productImage;
  String productDescription;
  int productDiscount;
  dynamic productPrice;
  dynamic productOldPrice;
  int productId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(productName),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image(
                            image: NetworkImage(productImage),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.changeFavorites(
                                  productId
                              );
                              print(productId);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: cubit.favorites[productId]!
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                        if (productDiscount != 0)
                          Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: const Text(
                            'DISCOUNT',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        'EGP',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800]
                        ),
                      ),
                      const SizedBox(width: 7,),
                      Text(
                        "$productPrice",
                        style: const TextStyle(fontSize: 18, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                        if (productDiscount != 0)
                          Text(
                          "$productOldPrice",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    productDescription,
                    style: TextStyle(
                        wordSpacing: 5,
                        height: 2,
                      color: Colors.grey[600],
                      fontSize: 15
                    ),
                  ),

                ],
              ),
            ),
          ),
          bottomNavigationBar:  Container(
            width: double.infinity,
            height: height(context, 9),
            color: Colors.grey[200],
            child:Padding(
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20,top: 10,bottom: 10),
              child:ConditionalBuilder(
                  condition: state is! AddDeleteCartLoadingState,
                  builder: (context)=> InkWell(
                      onTap: (){
                        cubit.addOrDeleteToCart(
                          productId: productId,
                        );
                      },
                      child:Container(
                          width:width(context, 1.43),
                          height: height(context, 11),
                          decoration: BoxDecoration(
                              color: defaultColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: const Center(
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                  color: Colors.white,
                                  wordSpacing: 10,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                      )
                  ),
                  fallback: (context)=>const Center(
                    child: CircularProgressIndicator(),
                  )
              )
            )
          ),
        );
      },
    );
  }
}
