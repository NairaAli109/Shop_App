// ignore_for_file: avoid_print
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/product/product_details_screen.dart';
import 'package:shop_app_flutter/shared/styles/size.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../setting/banner_details_screen.dart';
import '../setting/banners_screen.dart';
import '../categories/category_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesSuccessState){
          if(!state.changeFavoritesModel.status!){
            showToast(
                text: state.changeFavoritesModel.message!,
                states: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: cubit.homeModel!.data!.banners!
                          .map((e) => InkWell(
                        onTap: (){
                          navigateTo(context, BannerDetailScreen(
                            bannerImage: e.image!,
                          )
                          );
                        },
                        child: Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      )
                          .toList(),
                      options: CarouselOptions(
                          height: 250,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ///CATEGORIES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 130,
                          color: Colors.grey,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>InkWell(
                              onTap: (){
                                navigateTo(context, CategoryDetailsScreen(
                                  categoryName: cubit.categoriesModel!.data!.data![index].name!,
                                  categoryImage: cubit.categoriesModel!.data!.data![index].image!,
                                ));
                              },
                              child:  Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Image(
                                    image: NetworkImage(cubit.categoriesModel!.data!.data![index].image!),
                                    height: 130,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 130,
                                    color: Colors.black.withOpacity(0.8),
                                    child:  Text(
                                      cubit.categoriesModel!.data!.data![index].name!,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 10,),
                            itemCount: cubit.categoriesModel!.data!.data!.length,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'New Products',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ///NEW PRODUCTS
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1 / 1.54,
                        children: List.generate(
                          cubit.homeModel!.data!.products!.length,
                              (index) =>
                                  InkWell(
                                    onTap: (){
                                      navigateTo(context,  ProductDetailsScreen(
                                        productName:  cubit.homeModel!.data!.products![index].name!,
                                        productImage:cubit.homeModel!.data!.products![index].image!,
                                        productDiscount: cubit.homeModel!.data!.products![index].discount!,
                                        productId: cubit.homeModel!.data!.products![index].id!,
                                        productOldPrice: cubit.homeModel!.data!.products![index].oldPrice!,
                                        productPrice: cubit.homeModel!.data!.products![index].price!,
                                        productDescription: cubit.homeModel!.data!.products![index].description!,
                                      ));
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment: AlignmentDirectional.topStart,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional.bottomEnd,
                                                children: [
                                                  Image(
                                                    image: NetworkImage(cubit.homeModel!.data!.products![index].image!),
                                                    width: double.infinity,
                                                    height: 200,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsetsDirectional.only(end: 5),
                                                      child:InkWell(
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
                                                      )
                                                  ),
                                                ],
                                              ),
                                              if (cubit.homeModel!.data!.products![index].discount != 0)
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
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${cubit.homeModel!.data!.products![index].name}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    height: 1.3,
                                                  ),
                                                ),
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
                                                      "${cubit.homeModel!.data!.products![index].price}",
                                                      style: const TextStyle(fontSize: 14, color: defaultColor),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (cubit.homeModel!.data!.products![index].discount != 0)
                                                      Text(
                                                        "${cubit.homeModel!.data!.products![index].oldPrice}",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          decoration: TextDecoration.lineThrough,
                                                        ),
                                                      ),
                                                    const Spacer(),
                                                    ///FAVORITE ICON
                                                    IconButton(
                                                      onPressed: () {
                                                        cubit.changeFavorites(cubit.homeModel!.data!.products![index].id!);
                                                      },
                                                      icon:  Icon(
                                                        Icons.favorite,
                                                        color: cubit.favorites[cubit.homeModel!.data!.products![index].id]!
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                        )
                    ),
                  )
                ],
              ),
            ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

}
