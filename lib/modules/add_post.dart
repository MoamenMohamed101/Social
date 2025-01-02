import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            whatLeading: true,
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (cubit.postImage == null) {
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textEditingController.text,
                    );
                  } else {
                    cubit.createPostWithImage(
                      dateTime: now.toString(),
                      text: textEditingController.text,
                    );
                  }
                },
                child: Text(
                  'POST',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.deepPurple),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoading ||
                    state is SocialCreatePostWithImageLoading)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoading ||
                    state is SocialCreatePostWithImageLoading)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        cubit.userModel!.image!,
                      ),
                      radius: 25,
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
                                cubit.userModel!.name!,
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
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'What is in your mind ${cubit.userModel!.name!}',
                    ),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        child: IconButton(
                          onPressed: () {
                            cubit.deleteImage();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                cubit.getPostImage();
                              },
                              child: const Row(
                                children: [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('add photo')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
