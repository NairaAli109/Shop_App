import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit= ShopAppCubit.get(context);
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background4.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                'About',
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 45,top: 20,end: 20),
                  child:  Center(
                    child: Text(
                      cubit.settingModel!.data!.about!,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize:16,
                        wordSpacing: 5,
                        height: 2,
                      ),
                    ),
                  ),
                )
            ),
          ),
        );
      },
    );
  }
}
