import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (BuildContext context) => Column(
            children: [
              if (FirebaseAuth.instance.currentUser!.emailVerified == false)
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.amber.withOpacity(.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Please verify your email",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        commonTextButton(
                          text: "send",
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          function: () {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then(
                              (onValue) {
                                showToast(
                                  message: "Check your email",
                                  state: ToastStates.success,
                                );
                              },
                            ).catchError(
                              (onError) {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
