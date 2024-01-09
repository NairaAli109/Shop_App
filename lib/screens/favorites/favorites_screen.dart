// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../product/product_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.favoritesModel!.data!.data!.isNotEmpty,
            builder: (context)=>  ListView.separated(
              itemBuilder: (context, index) =>InkWell(
                onTap: (){
                  navigateTo(context,  ProductDetailsScreen(
                    productName:  cubit.favoritesModel!.data!.data![index].product!.name!,
                    productImage:cubit.favoritesModel!.data!.data![index].product!.image!,
                    productDiscount: cubit.favoritesModel!.data!.data![index].product!.discount!,
                    productId: cubit.favoritesModel!.data!.data![index].product!.id!,
                    productOldPrice: cubit.favoritesModel!.data!.data![index].product!.oldPrice!,
                    productPrice:cubit.favoritesModel!.data!.data![index].product!.price!,
                    productDescription: cubit.favoritesModel!.data!.data![index].product!.description!,
                  ));
                  print(cubit.favoritesModel!.data!.data![index].product!.id);
                },
                child: SizedBox(
                  height: 150,
                  child:Padding(
                    padding: const EdgeInsets.all(20),
                    child:  Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image(
                              image: NetworkImage(cubit.favoritesModel!.data!.data![index].product!.image!),
                              width: 150,
                              height: 150,
                            ),
                            if (cubit.favoritesModel!.data!.data![index].product!.discount != 0)
                              Container(
                                color: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: const Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                    cubit.favoritesModel!.data!.data![index].product!.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      height: 1.3,
                                    ),
                                  ),
                                  ),
                                  ///FAVORITE ICON
                                  IconButton(
                                    onPressed: () {
                                      cubit.changeFavorites(cubit.favoritesModel!.data!.data![index].product!.id!);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: cubit.favorites[cubit.favoritesModel!.data!.data![index].product!.id!]!
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    'EGP',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[800]
                                    ),
                                  ),
                                  const SizedBox(width: 7,),
                                  Text(
                                    "${cubit.favoritesModel!.data!.data![index].product!.price!}",
                                    style: const TextStyle(
                                        fontSize: 14, color: defaultColor),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (cubit.favoritesModel!.data!.data![index].product!.discount != 0)
                                    Text(
                                      "${cubit.favoritesModel!.data!.data![index].product!.oldPrice!}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: (){
                                      cubit.addOrDeleteToCart(
                                          productId: cubit.homeModel!.data!.products![index].id!
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey[300],
                                      child: Icon(
                                        Icons.shopping_cart_rounded,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => const Center(
              child: Text(
                'There is no favorite items yet',
                style: TextStyle(
                  color: Colors.grey,
                  wordSpacing: 15,
                ),
              ),
            )
        );
      },
    );
  }
}
