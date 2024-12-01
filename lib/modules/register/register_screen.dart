import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/register/register_cubit/register_cubit.dart';
import 'package:social/modules/register/register_cubit/register_state.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/app_strings.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController(),
      phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showToast(
              message: "Register done successfully",
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.register,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      AppStrings.registerSubTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextFormField(
                      validate: (value) =>
                          value!.isEmpty ? "Please enter your email" : null,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      radius: 10,
                      hintText: "enter your email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      validate: (value) =>
                          value!.isEmpty ? "Please enter your password" : null,
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Icons.password,
                      radius: 10,
                      hintText: "enter your password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      validate: (value) =>
                          value!.isEmpty ? "Please enter your name" : null,
                      controller: nameController,
                      textInputType: TextInputType.name,
                      prefixIcon: Icons.person,
                      radius: 10,
                      hintText: "enter your name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      validate: (value) =>
                          value!.isEmpty ? "Please enter your phone" : null,
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      radius: 10,
                      hintText: "enter your phone",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoading,
                      builder: (BuildContext context) => defaultButton(
                        text: AppStrings.register,
                        voidCall: () {
                          if (formKey.currentState!.validate()) {
                            cubit.registerUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      fallback: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
