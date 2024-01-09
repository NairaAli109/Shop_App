import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/profile/profile_screen.dart';
import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/size.dart';
import '../setting/about_screen.dart';
import '../setting/banners_screen.dart';
import '../setting/terms_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  Color  navColor= Colors.white;
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
            backgroundColor: navColor,
            appBar: AppBar(
              backgroundColor: navColor,
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                if(cubit.currentIndex==0)
                  searchIconButton(context),
                if(cubit.currentIndex==1)
                  searchIconButton(context),
                if(cubit.currentIndex==2)
                  searchIconButton(context),
              ],
            ),
            body:cubit.bottomNavScreens[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: navColor,
              onTap: (index){
                cubit.changeBottom(index);
                if(cubit.currentIndex==0){
                  navColor=Colors.white;
                }
                else{
                  navColor=Colors.transparent;
                }
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_rounded,),
                    label: 'Cart'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline,),
                      label: 'Account'
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
