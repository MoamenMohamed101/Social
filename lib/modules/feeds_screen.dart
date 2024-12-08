import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/shared/styles/app_assets.dart';
import 'package:social/shared/styles/icon_broken.dart';

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
          builder: (BuildContext context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.coverImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Share your ideas",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      buildItemBuilder(context),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildItemBuilder(BuildContext context) => Card(
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/68965871_2428019140768142_7568072189069492224_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_ohc=N6SlZb7CCx4Q7kNvgFir-Z6&_nc_zt=23&_nc_ht=scontent.fcai19-2.fna&_nc_gid=AxDCWxKRlNXdiBWielnJeAC&oh=00_AYAsUdDJQk3lx9ydhiJ2VqlPGPxEDYwMEd2rDTtEAiNSkw&oe=67767193',
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
                              "Moamen Mohamed",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 20,
                            )
                          ],
                        ),
                        Text(
                          "January 21, 2025 at 11:00.pm",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    height: 1.4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 18,
                    ),
                  )
                ],
              ),
              const Divider(),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppAssets.coverImage,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 30,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const Text(
                            '1200',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 32,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                IconBroken.Chat,
                                color: Colors.orangeAccent,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const Text(
                            '512',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            'comments',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/68965871_2428019140768142_7568072189069492224_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_ohc=N6SlZb7CCx4Q7kNvgFir-Z6&_nc_zt=23&_nc_ht=scontent.fcai19-2.fna&_nc_gid=AxDCWxKRlNXdiBWielnJeAC&oh=00_AYAsUdDJQk3lx9ydhiJ2VqlPGPxEDYwMEd2rDTtEAiNSkw&oe=67767193',
                                ),
                                radius: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'write a commit...',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 32,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Text(
                    '512',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 20,
                    width: 32,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Upload,
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
/*
Verification design
*  if (FirebaseAuth.instance.currentUser!.emailVerified == false)
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
*
*
* */
