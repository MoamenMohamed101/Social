import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/chat_screen.dart';
import 'package:social/shared/components/components.dart';

class ChatItemsScreen extends StatelessWidget {
  const ChatItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      builder: (BuildContext context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.allUsers.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            itemCount: cubit.allUsers.length,
            itemBuilder: (BuildContext context, int index) =>
                chatBuildItem(context,cubit.allUsers[index]),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget chatBuildItem(BuildContext context, UserModel user) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            navigateTo(context: context,widget: ChatScreen(user));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.image!
                ),
                radius: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 17,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
