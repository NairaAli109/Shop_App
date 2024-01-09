import 'package:shop_app_flutter/model/cart_model/get_cart_model.dart';
import 'package:shop_app_flutter/model/favorites_model.dart';
import 'package:shop_app_flutter/model/register_model.dart';
import 'package:shop_app_flutter/model/search_model.dart';

import '../../model/banners_model.dart';
import '../../model/cart_model/add_or_delete_to_cart_model.dart';
import '../../model/categories_model.dart';
import '../../model/change_favorites_model.dart';
import '../../model/login_model.dart';
import '../../model/profile_model.dart';
import '../../model/setting_model.dart';
import '../../model/update_profile_model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeModeState extends AppStates{}

///LOGIN STATES
abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  final LoginModel loginModel;
  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  late final String error;
  ShopLoginErrorStates(this.error);
}

class ShopChangePasswordVisibilityStates extends ShopLoginStates {}

///REGISTER STATES
abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}

class RegisterSuccessStates extends RegisterStates {
  final RegisterModel registerModel;
  RegisterSuccessStates(this.registerModel);
}

class RegisterErrorStates extends RegisterStates {
  final String error;
  RegisterErrorStates(this.error);
}

class RegisterChangePasswordVisibilityStates extends RegisterStates {}

class RegisterChangeConfirmPasswordVisibilityStates extends RegisterStates {}


///SHOP APP STATES
abstract class ShopAppStates {}

class ShopInitialStates extends ShopAppStates {}

///BOTTOM NAV BAR
class ShopChangeBottomNavStates extends ShopAppStates {}

///BOTTOM NAV BAR HOME
class ShopLoadingHomeDataState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErrorHomeDataState extends ShopAppStates {}

///BOTTOM NAV BAR CATEGORIES
class CategoriesLoadingState extends ShopAppStates {}

class CategoriesSuccessState extends ShopAppStates {
  final CategoriesModel categoriesModel;
  CategoriesSuccessState(this.categoriesModel);
}

class CategoriesErrorState extends ShopAppStates {}

///BOTTOM NAV BAR FAV
class ChangeFavoritesState extends ShopAppStates {}

class ChangeFavoritesSuccessState extends ShopAppStates {
  final ChangeFavoritesModel changeFavoritesModel;
  ChangeFavoritesSuccessState(this.changeFavoritesModel);
}

class ChangeFavoritesErrorState extends ShopAppStates {}

class GetFavoritesLoadingState extends ShopAppStates {}

class GetFavoritesSuccessState extends ShopAppStates {}

class GetFavoritesErrorState extends ShopAppStates {}

///PROFILE STATES

class GetProfileDataLoadingState extends ShopAppStates {}

class GetProfileDataSuccessState extends ShopAppStates {
  final ProfileModel profileModel;
  GetProfileDataSuccessState(this.profileModel);
}

class GetProfileDataErrorState extends ShopAppStates {}

class UpdateProfileLoadingState extends ShopAppStates {}

class UpdateProfileSuccessState extends ShopAppStates {
  final UpdateProfileModel updateProfileModel;
  UpdateProfileSuccessState(this.updateProfileModel);
}

class UpdateProfileErrorState extends ShopAppStates {}

///SETTINGS
abstract class SettingStates {}

class SettingInitialStates extends SettingStates {}

class SettingLoadingState extends ShopAppStates {}

class SettingSuccessState extends ShopAppStates {
  late final SettingModel settingModel;
  SettingSuccessState(this.settingModel);
}

class GetSettingErrorState extends ShopAppStates {}

///IMAGE PICKER STATE
class ChooseImageState extends ShopAppStates {}
class RegisterChooseImageState extends RegisterStates {}

///BANNERS STATES
class GetBannerDataLoadingState extends ShopAppStates {}

class GetBannerDataSuccessState extends ShopAppStates {
  final BannersModel bannersModel;
  GetBannerDataSuccessState(this.bannersModel);
}

class GetBannerDataErrorState extends ShopAppStates {}

///SEARCH STATES
abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final SearchModel searchModel;
  SearchSuccessState(this.searchModel);
}

class SearchErrorState extends SearchStates {}

///CART
class GetCartLoadingState extends ShopAppStates {}

class GetCartSuccessState extends ShopAppStates {
  final GetCartModel getCartModel;
  GetCartSuccessState(this.getCartModel);
}

class GetCartErrorState extends ShopAppStates {}

class AddDeleteCartLoadingState extends ShopAppStates {}

class AddDeleteCartSuccessState extends ShopAppStates {
  final AddOrDeleteToCartModel addOrDeleteToCartModel;
  AddDeleteCartSuccessState(this.addOrDeleteToCartModel);
}

class AddDeleteCartErrorState extends ShopAppStates {}

