// ignore_for_file: avoid_print

import 'package:shop_app_flutter/shared/component/components.dart';
import '../../screens/login/login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text)
{
  final pattern= RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token='';