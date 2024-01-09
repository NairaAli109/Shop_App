// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/profile/profile_image_screen.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          if (state.updateProfileModel.status!) {
            CacheHelper.saveData(
                    key: token!, value: state.updateProfileModel.data!.token)
                .then((value) {
              navigateBack(context);
            });
          }
        }
      },
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
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 35),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(state is UpdateProfileLoadingState)
                          const Column(
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            InkWell(
                              onTap: (){
                                navigateTo(context, const ProfileImageScreen()
                                );
                              },
                              child:CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey[400],
                                child: ClipOval(
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
                            InkWell(
                              onTap: (){
                                cubit.addImage();
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name  must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          preIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'E-mail  must not be empty';
                              }
                              return null;
                            },
                            label: 'E-mail Address',
                            preIcon: Icons.email_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Phone  must not be empty';
                              }
                              return null;
                            },
                            label: 'Phone',
                            preIcon: Icons.phone
                        ),
                        const SizedBox(height: 60,),
                        Row(
                          children: [
                            Expanded(
                              child: defaultButton(
                                  function: () {
                                    navigateBack(context);
                                  },
                                  text: 'Cancel'),
                            ),
                            Expanded(
                              child: defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.updateUserData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Save'
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
        );
      },
    );
  }
}
