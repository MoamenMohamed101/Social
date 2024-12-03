import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/modules/add_post.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialChangeIndexUploadPost) {
          navigateTo(
            context: context,
            widget: const AddPost(),
          );
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.appBarTexts[cubit.currentIndex],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.items,
          ),
          body: cubit.pages[cubit.currentIndex],
        );
      },
    );
  }
}
