import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/styles/icon_broken.dart';

class ChatScreen extends StatelessWidget {
  final UserModel? user;

  ChatScreen(this.user, {super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(user!.uId!);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user!.image!),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(user!.name!),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.messages.isNotEmpty,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var message = cubit.messages[index];
                          if (cubit.userModel!.uId == message.senderId) {
                            return buildMyMessage(cubit.messages[index]);
                          }
                          return buildMessage(cubit.messages[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 15,
                        ),
                        itemCount: cubit.messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'write your message..',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              cubit.sendMessage(
                                receiverId: user!.uId!,
                                text: textEditingController.text,
                                dateTime: DateTime.now().toString(),
                              );
                              cubit.getMessages(user!.uId!);
                            },
                            minWidth: 1,
                            child: const Icon(IconBroken.Send),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel message) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text(
            message.text!,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel message) => Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.5),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Text(
              message.text!,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
}
