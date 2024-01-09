// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../screens/search/search_screen.dart';
import '../styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateBack(context)=>Navigator.pop(context);


Widget myDivider()=>const Divider(thickness: 2,);

void showToast({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARRNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = defaultColor;
      break;
    case ToastStates.WARRNING:
      color = Colors.yellowAccent;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  required String? Function(String?) validator,
  required String label,
  required IconData preIcon,
  IconData? suffIcon,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(preIcon,color: defaultColor,),
          suffixIcon: suffIcon != null
              ? IconButton(
              onPressed: () {
                suffixPressed!();
                },
              icon: Icon(suffIcon))
              : null,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          )
      ),
    );

Widget searchTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validator,
  required String hint,
  required IconData preIcon,
  IconData? suffIcon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(preIcon,color: Colors.grey,),
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
          )
      ),
    );

Widget defaultButton({
  // double width=double.infinity,
  double width = 180,
  Color background = defaultColor,
  bool isUpperCase = true,
  required VoidCallback function, // Change the parameter type to VoidCallback
  required String text,
  double raduis = 12.5,
}) =>
    Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis),
          color: background,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
          text.toUpperCase(),
        style: const TextStyle(
          fontSize: 18
        ),
      ),
    );

Widget searchIconButton(context) =>  IconButton(
    onPressed: (){
      navigateTo(context,  SearchScreen());
    },
    icon: const Icon(Icons.search,color: Colors.grey,)
);

