import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/modules/chat_screen.dart';
import 'package:social/modules/feeds_screen.dart';
import 'package:social/modules/posts_screen.dart';
import 'package:social/modules/settings_screen.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(SocialChangeIndex());
  }

  List<Widget> pages = [
    const FeedsScreen(),
    const ChatScreen(),
    const PostsScreen(),
    const SettingsScreen()
  ];
  List<String> appBarTexts = ["Home", "Chat", "Posts", "Setting"];
}
