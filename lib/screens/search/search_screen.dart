// ignore_for_file: null_check_always_fails

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/search/search_detailed_screen.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';

import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../product/product_details_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          var favCubit = ShopAppCubit.get(context);
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background4.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                body: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, top: 10, end: 20, bottom: 20),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          searchTextFormField(
                              controller: searchController,
                              type: TextInputType.text,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'their is nothing to search about';
                                }
                                return null;
                              },
                              hint: 'Search',
                              preIcon: Icons.search,
                              onSubmit: (String text) {
                                cubit.search(text: text);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is SearchLoadingState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is SearchSuccessState)
                            Expanded(
                                child: ListView.separated(
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  navigateTo(context, SearchDetailsScreen(
                                    productName: cubit.searchModel!.data!.data![index].name!,
                                    productDescription:  cubit.searchModel!.data!.data![index].description!,
                                    productPrice:  cubit.searchModel!.data!.data![index].price,
                                    productId:  cubit.searchModel!.data!.data![index].id,
                                    productImage:  cubit.searchModel!.data!.data![index].image!,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: NetworkImage(cubit.searchModel!
                                            .data!.data![index].image!),
                                        width: 100,
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.searchModel!.data!
                                                  .data![index].name!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                height: 1.3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'EGP',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[800]),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  "${cubit.searchModel!.data!.data![index].price}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: defaultColor),
                                                ),
                                                const Spacer(),
                                                ///FAVORITE ICON
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: favCubit.favorites[
                                                            favCubit
                                                                .homeModel!
                                                                .data!
                                                                .products![
                                                                    index]
                                                                .id]!
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: cubit.searchModel!.data!.data!.length,
                            ))
                        ],
                      )),
                )),
          );
        },
      ),
    );
  }
}
