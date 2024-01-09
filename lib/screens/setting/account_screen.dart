import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/setting/terms_screen.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/size.dart';
import '../profile/profile_screen.dart';
import 'about_screen.dart';
import 'banners_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 30, end: 30, top: 30, bottom: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, ProfileScreen());
                        },
                        child: CircleAvatar(
                          radius: 35,
                          child: ClipOval(
                            child: cubit.image == null
                                ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        cubit.profileModel!.data!.image!),
                                    fit: BoxFit.cover
                                ),
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(cubit.image!),
                                      fit: BoxFit.cover
                                  )
                              ),
                            )
                            ,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person_add_alt_outlined,
                            size: 27,
                            color: defaultColor,
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      navigateTo(context, ProfileScreen());
                    },
                    child: Text(
                      "${cubit.profileModel!.data!.name}",
                      style: const TextStyle(
                        color: defaultColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, ProfileScreen());
                    },
                    child: Text(
                      "${cubit.profileModel!.data!.email}",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  navigateTo(context, const BannersScreen());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 30,),
                    Text(
                      "Banners",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  navigateTo(context, const AboutScreen());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.align_vertical_bottom_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 30,),
                    Text(
                      "About",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  navigateTo(context, const TermsScreen());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.featured_play_list_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 30,),
                    Text(
                      "Terms",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  signOut(context);
                },
                child: Container(
                  width: width(context, 2.7),
                  height: 50,
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: defaultColor,
                      )
                  ),
                  child: const Center(
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
