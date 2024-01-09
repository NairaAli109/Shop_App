import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import 'category_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context).categoriesModel;
        return ListView.separated(
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              navigateTo(context, CategoryDetailsScreen(
                categoryName: cubit.data!.data![index].name!,
                categoryImage: cubit.data!.data![index].image!,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(cubit!.data!.data![index].image!),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    cubit.data!.data![index].name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit!.data!.data!.length,
        );
      },
    );
  }
}
