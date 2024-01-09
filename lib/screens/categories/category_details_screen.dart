import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen
      ({
    Key? key,
    required this.categoryName,
    required this.categoryImage
  })
      : super(key: key);

  String categoryName;
  String categoryImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
               Expanded(
                 child:  Image(
                 image: NetworkImage(categoryImage),
                 ),
               ),
               Expanded(
                 child:  Center(
                   child: Text(
                     'There is no data about $categoryName to explain',
                     style: TextStyle(
                         color: Colors.grey[600],
                         wordSpacing: 5
                     ),
                   ),
                 ),
               )
              ],
            ),
          ),
        );
      },
    );
  }
}
