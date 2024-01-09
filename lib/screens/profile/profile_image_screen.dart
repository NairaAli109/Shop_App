import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/shared/component/components.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';

class ProfileImageScreen extends StatelessWidget {
  const ProfileImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit= ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateBack(context);
              },
              icon: const Icon(
                  Icons.close_outlined
              ),
            ),
          ),
          body: Center(
            child: cubit.image == null
                ? Image(
              image: NetworkImage(cubit.profileModel!.data!.image!),
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Image(
              image: FileImage(cubit.image!),
              width: double.infinity,
              fit: BoxFit.cover,
            )
          ),
        );
      },
    );
  }
}
