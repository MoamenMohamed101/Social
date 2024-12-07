import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController(),
      bioController = TextEditingController(),
      phoneController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        nameController.text = cubit.userModel!.name!;
        bioController.text = cubit.userModel!.bio!;
        phoneController.text = cubit.userModel!.phone!;
        passwordController.text = cubit.userModel!.password!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            whatLeading: true,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: TextButton(
                  onPressed: () {
                    cubit.updateUserData(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                        password: passwordController.text);
                  },
                  child: Text(
                    'UPDATE',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18, color: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdateUserDataLoading)
                    const LinearProgressIndicator(),
                  if (state is SocialUpdateUserDataLoading)
                    const SizedBox(
                      height: 10,
                    ),
                  SizedBox(
                    height: 230,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: cubit.coverImage == null
                                        ? NetworkImage(cubit.userModel!.cover!)
                                        : FileImage(cubit.coverImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: CircleAvatar(
                                  radius: 18,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage(
                                        cubit.userModel!.image!,
                                      )
                                    : FileImage(cubit.profileImage!),
                                radius: 60,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (cubit.coverImage != null || cubit.profileImage != null)
                    Row(
                      children: [
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  text: 'update cover',
                                  voidCall: () => cubit.uploadCoverImage(
                                    name: nameController.text,
                                    password: passwordController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                  ),
                                  textSize: 15,
                                ),
                                if (state is SocialUploadCoverImageLoading)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  text: 'update profile',
                                  voidCall: () => cubit.uploadProfileImage(
                                    name: nameController.text,
                                    password: passwordController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                  ),
                                  textSize: 15,
                                ),
                                if (state is SocialUploadProfileImageLoading)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    validate: (value) =>
                        value!.isEmpty ? 'name is empty' : null,
                    controller: nameController,
                    textInputType: TextInputType.text,
                    prefixIcon: IconBroken.User,
                    radius: 10,
                    hintText: 'enter your phone name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    validate: (value) =>
                        value!.isEmpty ? 'password is empty' : null,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: IconBroken.Password,
                    radius: 10,
                    hintText: 'enter your password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    validate: (value) => value!.isEmpty ? 'bio is empty' : null,
                    controller: bioController,
                    textInputType: TextInputType.text,
                    prefixIcon: IconBroken.Info_Circle,
                    radius: 10,
                    hintText: 'enter your bio',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    validate: (value) =>
                        value!.isEmpty ? 'phone is empty' : null,
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    prefixIcon: IconBroken.Call,
                    radius: 10,
                    hintText: 'enter your phone number',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
