// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/size.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../product/product_details_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.getCartModel!.data!.cartItems!.isNotEmpty,
            builder: (context)=> Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        navigateTo(context,  ProductDetailsScreen(
                          productName:  cubit.getCartModel!.data!.cartItems![index].product!.name!,
                          productImage:cubit.getCartModel!.data!.cartItems![index].product!.image!,
                          productDiscount: cubit.getCartModel!.data!.cartItems![index].product!.discount!,
                          productId: cubit.getCartModel!.data!.cartItems![index].product!.id!,
                          productOldPrice: cubit.getCartModel!.data!.cartItems![index].product!.oldPrice!,
                          productPrice: cubit.getCartModel!.data!.cartItems![index].product!.price!,
                          productDescription: cubit.getCartModel!.data!.cartItems![index].product!.description!,
                        ));
                      },
                      child: SizedBox(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                    image: NetworkImage(cubit.getCartModel!.data!.cartItems![index].product!.image!),
                                    width: 150,
                                    height: 150,
                                  ),
                                  if (cubit.getCartModel!.data!.cartItems![index].product!
                                      .discount !=
                                      0)
                                    Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: const Text(
                                        'DISCOUNT',
                                        style:
                                        TextStyle(fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.getCartModel!.data!.cartItems![index].product!.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        height: 1.3,
                                      ),
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
                                          "${cubit.getCartModel!.data!.cartItems![index].product!.price!}",
                                          style: const TextStyle(
                                              fontSize: 14, color: defaultColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        if (cubit.getCartModel!.data!.cartItems![index].product!.discount !=
                                            0)
                                          Text(
                                            "${cubit.getCartModel!.data!.cartItems![index].product!.oldPrice!}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),

                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          width: width(context, 4.4),
                                          height: height(context, 26),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.circular(20)),
                                          child:  Row(
                                            children: [
                                              InkWell(
                                                child: const Icon(Icons.remove),
                                                onTap: (){
                                                  setState(() {
                                                    if( cubit.getCartModel!.data!.cartItems![index].quantity >0){
                                                      cubit.getCartModel!.data!.cartItems![index].quantity = cubit.getCartModel!.data!.cartItems![index].quantity - 1;
                                                    }
                                                    else{
                                                      cubit.getCartModel!.data!.cartItems![index].quantity = 0;
                                                    }
                                                  });
                                                },
                                              ),
                                              const VerticalDivider(
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                  "${cubit.getCartModel!.data!.cartItems![index].quantity}"
                                              ),
                                              const VerticalDivider(
                                                color: Colors.grey,
                                              ),
                                              InkWell(
                                                child: const Icon(Icons.add),
                                                onTap: (){
                                                  setState(() {
                                                    cubit.getCartModel!.data!.cartItems![index].quantity = cubit.getCartModel!.data!.cartItems![index].quantity + 1;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: (){
                                            cubit.addOrDeleteToCart(
                                                productId: cubit.getCartModel!.data!.cartItems![index].product!.id!
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey[200],
                                            child: Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.grey[700],
                                              size: 29,
                                            ),
                                          ),
                                        )
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
                    itemCount: cubit.getCartModel!.data!.cartItems!.length,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: height(context, 10),
                  color: Colors.grey[200],
                  child:  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15,end: 15,top: 10,bottom: 10),
                    child: Container(
                      width:width(context, 1.43),
                      height: height(context, 11),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)
                      ),
                      child:  Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10,end: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                    fontSize: 25
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'EGP',
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "${ cubit.getCartModel!.data!.total}",
                                style: TextStyle(
                                    color: Colors.grey[700]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  )
                )
              ],
            ),
            fallback: (context)=> const Center(
                child: Text(
                  'Your Cart is empty',
                  style: TextStyle(
                      color: Colors.grey,
                      wordSpacing: 15
                  ),
                )
            )
        );
      },
    );
  }
}

