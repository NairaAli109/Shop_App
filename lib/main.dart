// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/home/home_screen.dart';
import 'package:shop_app_flutter/screens/login/login_screen.dart';
import 'package:shop_app_flutter/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop_app_flutter/shared/bloc_observer.dart';
import 'package:shop_app_flutter/shared/component/constants.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';
import 'package:shop_app_flutter/shared/styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token= CacheHelper.getData(key: 'token');

  if(onBoarding!=null){
    if(token!=null){
      widget= HomeScreen();
    }
    else{
      widget=LoginScreen();
    }
  }
  else{
    widget=const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({super.key,required this.isDark,required this.startWidget,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark,),),
        BlocProvider(create: (context) => ShopAppCubit()..getProfileData()..getHomeData()..getCategoriesData()..getFavoritesData()..getSettingData()..getCart()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: lightTheme,
            darkTheme: darkTheme,
            home:    Directionality(
              textDirection: TextDirection.ltr,
              child: OnBoardingScreen(),
            ),
          );
        },
      ),
    );
  }
}
