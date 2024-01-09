// ignore_for_file: avoid_print, body_might_complete_normally_nullable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token
              ).then((value){
                token= state.loginModel.data!.token!;
                showToast(
                  text: state.loginModel.message!,
                  states: ToastStates.SUCCESS,
                );
                navigateAndFinish(
                  context,
                   HomeScreen(),
                );
              });
            }
            else {
              print(state.loginModel.message);
              showToast(
                  text:'Welcome back ${ state.loginModel.message!}',
                  states: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Container(
            decoration:  const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background4.png'),
                    fit: BoxFit.cover
                )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("LOGIN",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Colors.black)
                              ),
                              const SizedBox(height: 15,),
                              Text("Login now to browse our hot offers",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.grey)
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              defaultTextFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "please enter your email address";
                                    }
                                  },
                                  label: 'Email Address',
                                  preIcon: Icons.email_outlined
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              defaultTextFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "password is too short ";
                                    }
                                  },
                                  label: 'Password',
                                  preIcon: Icons.lock_clock_outlined,
                                  suffIcon: ShopLoginCubit.get(context).suffix,
                                  isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    ShopLoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }
                                  ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! ShopLoginLoadingStates,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    text: 'Login',
                                    isUpperCase: true),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                  ),
                                  defaultTextButton(
                                      function: () {
                                        navigateAndFinish(
                                            context, const RegisterScreen()
                                        );
                                      },
                                      text: 'Register Now.'
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
