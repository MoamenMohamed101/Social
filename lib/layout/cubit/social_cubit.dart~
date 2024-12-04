import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/add_post.dart';
import 'package:social/modules/chat_screen.dart';
import 'package:social/modules/feeds_screen.dart';
import 'package:social/modules/posts_screen.dart';
import 'package:social/modules/settings_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: "Chats"),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Paper_Upload), label: "Post"),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Location), label: "Users"),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting), label: "Settings"),
  ];

  void changeIndex(int index) {
    if (index == 2) {
      emit(SocialChangeIndexUploadPost());
    } else {
      currentIndex = index;
      emit(SocialChangeIndex());
    }
  }

  List<Widget> pages = [
    const FeedsScreen(),
    const ChatScreen(),
    const AddPost(),
    const PostsScreen(),
    const SettingsScreen()
  ];
  List<String> appBarTexts = [
    "Home",
    "Chat",
    "Add Post",
    "Posts",
    "Setting",
  ];

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(token).get().then(
      (onValue) {
        userModel = UserModel.fromJson(onValue.data()!);
        emit(SocialGetUserDataSuccess());
      },
    ).catchError(
      (onError) {
        emit(SocialGetUserDataError());
      },
    );
  }
}
