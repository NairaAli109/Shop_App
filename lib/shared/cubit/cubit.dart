// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/model/cart_model/get_cart_model.dart';
import 'package:shop_app_flutter/model/register_model.dart';
import 'package:shop_app_flutter/model/search_model.dart';
import 'package:shop_app_flutter/model/update_profile_model.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';
import '../../model/cart_model/add_or_delete_to_cart_model.dart';
import '../../model/categories_model.dart';
import '../../model/change_favorites_model.dart';
import '../../model/favorites_model.dart';
import '../../model/home_model.dart';
import '../../model/login_model.dart';
import '../../model/profile_model.dart';
import '../../model/setting_model.dart';
import '../../screens/categories/categories_screen.dart';
import '../../screens/favorites/favorites_screen.dart';
import '../../screens/product/product_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/setting/account_screen.dart';
import '../component/constants.dart';
import '../network/end_points.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared!= null)
    {
      isDark=fromShared;
      //print('++++++++++++++++++++++++++from shared $isDark');
      emit(AppChangeModeState());
    }
    else
    {
      isDark=!isDark;
      // print('++++++++++++++++++++++++++is dark $isDark');
      CacheHelper.putBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit( ):super ( ShopLoginInitialStates());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingStates());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email ,
          'password':password,
        }
    ).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_rounded;
  bool isPassword= true;

  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix= isPassword? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ShopChangePasswordVisibilityStates());
  }
}

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super (RegisterInitialStates());

  static RegisterCubit get(context )=> BlocProvider.of(context);

  RegisterModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingStates());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value){
          registerModel=RegisterModel.fromJson(value.data);
          emit(RegisterSuccessStates(registerModel!));
        }).catchError((error){
          print(error.toString());
          emit(RegisterErrorStates(error));
        });
  }

  IconData suffix=Icons.visibility_rounded;
  bool isPassword= true;

  void changePasswordVisibility (){
    isPassword =! isPassword;
    suffix= isPassword? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(RegisterChangePasswordVisibilityStates());
  }

  IconData confirmSuffix=Icons.visibility_rounded;
  bool confirmIsPassword= true;

  void changeConfirmPasswordVisibility (){
    confirmIsPassword =! confirmIsPassword;
    confirmSuffix= confirmIsPassword? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(RegisterChangeConfirmPasswordVisibilityStates());
  }

}

class ShopAppCubit extends Cubit<ShopAppStates>{
  ShopAppCubit(): super (ShopInitialStates());

  static ShopAppCubit get(context)=>BlocProvider.of(context);

  /// BOTTOM NAV BAR
  int currentIndex=0;

  List<String> titles= [
    "Home",
    "Categories",
    "Favorites",
    "Cart",
    "Account",
  ];

  List<Widget> bottomNavScreens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    CartScreen(),
    const AccountScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavStates());
  }

  /// HOME
  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products?.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  /// CATEGORIES
  CategoriesModel? categoriesModel;
  void getCategoriesData(){

    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessState(categoriesModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(CategoriesErrorState());
    });
  }

  ///FAVORITES
  Map<int,bool> favorites={};
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId]= !favorites[productId]!;
    emit(ChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){

    emit(GetFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  ///PROFILE
  ProfileModel? profileModel;
  void getProfileData({
     String? name,
     String? email,
     String? phone,
     String? image,
  }){
    emit(GetProfileDataLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      profileModel=ProfileModel.fromJson(value.data);
      emit(GetProfileDataSuccessState(profileModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  UpdateProfileModel?updateProfileModel;
  void updateUserData({
    String? name,
    String? email,
    String? phone,
    String? image,
  }){
    emit(UpdateProfileLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
        'image':image
      },
    ).then((value){
      updateProfileModel=UpdateProfileModel.fromJson(value.data);
      print(updateProfileModel!.data!.name);
      getProfileData(
        name: name,
        email: email,
        phone: phone,
        image: image,
      );
      emit(UpdateProfileSuccessState(updateProfileModel!));
    }).catchError((error){
      print(error.toString());
      emit(UpdateProfileErrorState());
    });
  }

  ///CART
  GetCartModel? getCartModel;
  void getCart({int? productId}){
    emit(GetCartLoadingState());

    DioHelper.getData(
      url: GET_CART,
      token: token,
    ).then((value){
      getCartModel=GetCartModel.fromJson(value.data);
      emit(GetCartSuccessState(getCartModel!));
    }).catchError((error){
      print(error.toString());
      emit(GetCartErrorState());
    });

  }


  AddOrDeleteToCartModel?addOrDeleteToCartModel;
  void addOrDeleteToCart({
    required int productId
  }){
    emit(AddDeleteCartLoadingState());

    DioHelper.postData(
        url: GET_CART,
        data: {
          'product_id':productId,
        },
        token: token,
    ).then((value){
      addOrDeleteToCartModel=AddOrDeleteToCartModel.fromJson(value.data);
      print("${addOrDeleteToCartModel!.data!.product!.id} is ${addOrDeleteToCartModel!.message}");
      getCart(productId: productId);
      emit(AddDeleteCartSuccessState(addOrDeleteToCartModel!));
    }).catchError((error){
      print(error.toString());
      emit(AddDeleteCartErrorState());
    });
  }


  ///SETTING
  SettingModel? settingModel;
  void getSettingData(){

    emit(SettingLoadingState());

    DioHelper.getData(
      url: SETTINGS,
    ).then((value)
    {
      settingModel=SettingModel.fromJson(value.data);
      emit(SettingSuccessState(settingModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(GetSettingErrorState());
    });
  }

  ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  Future<void> addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      print('images = $userImage');
      emit(ChooseImageState());
    } else {
      print('no image selected');
    }
  }
}

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context )=> BlocProvider.of(context);

  SearchModel? searchModel;
  void search({String? text}){
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text
        }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState(searchModel!));
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
