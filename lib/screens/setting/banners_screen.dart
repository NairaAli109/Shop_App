import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/model/home_model.dart';
import 'package:shop_app_flutter/screens/setting/banner_details_screen.dart';
import 'package:shop_app_flutter/shared/component/components.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({
    Key? key,
  }) : super(key: key);

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
              title: const Text('Banners'),
              centerTitle: true,
            ),
            body:ConditionalBuilder(
                condition: state is! GetBannerDataLoadingState ,
                builder: (context)=> ListView.separated(
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: (){
                            navigateTo(context, BannerDetailScreen(
                              bannerImage: cubit.homeModel!.data!.banners![index].image!,
                            )
                            );
                          },
                          child: Image(
                            image: NetworkImage( cubit.homeModel!.data!.banners![index].image!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: 5
                ),
                fallback: (context)=> const Center(child: CircularProgressIndicator(),)
            )
        );
      },
    );
  }
}
