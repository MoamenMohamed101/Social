import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login/login_cubit/login_cubit.dart';
import 'package:social/modules/login/login_cubit/login_state.dart';
import 'package:social/modules/register/register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/app_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast(
              message: "Login done successfully",
              state: ToastStates.success,
            );
          }
          else if(state is LoginError) {
            showToast(
              message: state.error,
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
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
                      "Login",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      AppStrings.loginSubTitle,
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
                      iconButtonFunction: () {
                        cubit.changeIcon();
                      },
                      suffixIcon: cubit.isPassword ? Icons.visibility
                          : Icons.visibility_off,
                      isSuffix: true,
                      isObscure: cubit.isPassword,
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
                    ConditionalBuilder(
                      condition: state is! LoginLoading,
                      builder: (BuildContext context) => defaultButton(
                        text: AppStrings.login,
                        voidCall: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loginUser(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        commonTextButton(
                          text: AppStrings.register,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.blue),
                          function: () {
                            navigateTo(
                              context: context,
                              widget: RegisterScreen(),
                            );
                          },
                        ),
                      ],
                    )
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
