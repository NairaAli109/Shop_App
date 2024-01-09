// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/profile/profile_image_screen.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/size.dart';
import 'edit_Profile_Screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);

          nameController.text = cubit.profileModel!.data!.name!;
          emailController.text = cubit.profileModel!.data!.email!;
          phoneController.text = cubit.profileModel!.data!.phone!;

          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background4.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text("My Profile"),
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              body: ConditionalBuilder(
                  condition: cubit.profileModel != null,
                  builder: (context) => SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    navigateTo(context, const ProfileImageScreen()
                                    );
                                  },
                                  child:CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.grey[400],
                                    child:  ClipOval(
                                      child: cubit.image == null
                                          ?Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(cubit.profileModel!.data!.image!),
                                              fit: BoxFit.cover
                                          ),
                                        ),
                                      )
                                          :Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(cubit.image!),
                                                fit: BoxFit.fill
                                            )
                                        ),
                                      )
                                      ,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  cubit.profileModel!.data!.name!,
                                  style: const TextStyle(
                                      fontSize: 23, color: defaultColor),
                                ),
                                Text(
                                  cubit.profileModel!.data!.email!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width(context, 3.0),
                                      height: height(context, 6.5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Your Points',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "${cubit.profileModel!.data!.points!}",
                                            style: const TextStyle(
                                                color: defaultColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      width: width(context, 3.0),
                                      height: height(context, 6.5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Your Credit',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${cubit.profileModel!.data!.credit}',
                                            style: const TextStyle(
                                                color: defaultColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text('Your Email'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 18, top: 10),
                                      child: Text(
                                        cubit.profileModel!.data!.email!,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text('Phone number'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 18, top: 10),
                                      child: Text(
                                        cubit.profileModel!.data!.phone!,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          );
        },
      );
  }
  // Column(
  // children: [
  // defaultTextFormField(
  // controller: nameController,
  // type: TextInputType.name,
  // validator: (String? value) {
  // if (value!.isEmpty) {
  // return 'Name  must not be empty';
  // }
  // return null;
  // },
  // label: 'Name',
  // preIcon: Icons.person,
  // ),
  // const SizedBox(height: 20,),
  // defaultTextFormField(
  // controller: emailController,
  // type: TextInputType.emailAddress,
  // validator: (String? value) {
  // if (value!.isEmpty) {
  // return 'E-mail  must not be empty';
  // }
  // return null;
  // },
  // label: 'E-mail Address',
  // preIcon: Icons.email_outlined
  // ),
  // const SizedBox(height: 20,),
  // defaultTextFormField(
  // controller: phoneController,
  // type: TextInputType.phone,
  // validator: (String? value) {
  // if (value!.isEmpty) {
  // return 'Phone  must not be empty';
  // }
  // return null;
  // },
  // label: 'Phone',
  // preIcon: Icons.phone
  // ),
  // ],
  // )
}
