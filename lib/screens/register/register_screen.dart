// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/screens/home/home_screen.dart';
import 'package:shop_app_flutter/screens/login/login_screen.dart';
import 'package:shop_app_flutter/shared/component/components.dart';
import 'package:shop_app_flutter/shared/cubit/cubit.dart';
import 'package:shop_app_flutter/shared/cubit/states.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';

import '../../shared/component/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
            if (state.registerModel.status!) {
              print(state.registerModel.message);
              print(state.registerModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = state.registerModel.data!.token;
                showToast(
                    text:
                        'Welcome to our app ${state.registerModel.data!.name}',
                    states: ToastStates.SUCCESS);
                navigateAndFinish(context, HomeScreen());
              });
            } else {
              print(state.registerModel.message);
              showToast(
                text: state.registerModel.message!,
                states: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background4.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('SignUp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Colors.black)),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                child: Text(
                                    "SigUp now to make your first order",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey)),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultTextFormField(
                                  controller: nameController,
                                  type: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Name should be filled ";
                                    }
                                    return null;
                                  },
                                  label: "Name",
                                  preIcon: Icons.person_outline),
                              const SizedBox(
                                height: 25,
                              ),
                              defaultTextFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "E-mail should be filled ";
                                    }
                                    return null;
                                  },
                                  label: "E-mail",
                                  preIcon: Icons.email_outlined),
                              const SizedBox(
                                height: 25,
                              ),
                              defaultTextFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Password should be filled ";
                                    }
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return 'password does not match';
                                    }
                                    return null;
                                  },
                                  label: "Password",
                                  preIcon: Icons.lock,
                                  suffIcon: cubit.suffix,
                                  isPassword: cubit.isPassword,
                                  suffixPressed: () {
                                    cubit.changePasswordVisibility();
                                  }),
                              const SizedBox(
                                height: 25,
                              ),
                              defaultTextFormField(
                                  controller: confirmPasswordController,
                                  type: TextInputType.visiblePassword,
                                  validator: (String? value) {
                                    if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      return 'password does not match';
                                    }
                                    return null;
                                  },
                                  label: "Confirm Password",
                                  preIcon: Icons.lock,
                                  suffIcon: cubit.confirmSuffix,
                                  isPassword: cubit.confirmIsPassword,
                                  suffixPressed: () {
                                    cubit.changeConfirmPasswordVisibility();
                                  }),
                              const SizedBox(
                                height: 25,
                              ),
                              defaultTextFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Mobile number should be filled ";
                                    }
                                    return null;
                                  },
                                  label: "Mobile number",
                                  preIcon: Icons.phone_android),
                              const SizedBox(
                                height: 25,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingStates,
                                builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: "SignUp"),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                  ),
                                  defaultTextButton(
                                      function: () {
                                        navigateAndFinish(
                                            context, LoginScreen());
                                      },
                                      text: 'Log in.'),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                )),
          );
        },
      ),
    );
  }
}
