import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/cubit/social_state.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/add_post.dart';
import 'package:social/modules/chat_screen.dart';
import 'package:social/modules/feeds_screen.dart';
import 'package:social/modules/posts_screen.dart';
import 'package:social/modules/settings_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetProfileImageSuccess());
    } else {
      debugPrint('No image selected');
      emit(SocialGetProfileImageError());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetCoverImageSuccess());
    } else {
      debugPrint('No image selected');
      emit(SocialGetCoverImageError());
    }
  }

  List<Widget> pages = [
    const FeedsScreen(),
    const ChatScreen(),
    AddPost(),
    const PostsScreen(),
    const SettingsScreen(),
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

  void updateUserData({
    required String? name,
    required String? bio,
    required String? phone,
    required String? password,
    String? profile,
    String? cover,
  }) {
    emit(SocialUpdateUserDataLoading());
    UserModel updateUserModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      email: userModel!.email,
      password: password,
      image: profile ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(updateUserModel.toMap())
        .then(
      (onValue) {
        getUserData();
      },
    ).catchError(
      (onError) {
        print(onError.toString());
        emit(SocialUpdateUserDataError());
      },
    );
  }

  void uploadProfileImage({
    required String? name,
    required String? bio,
    required String? phone,
    required String? password,
  }) {
    emit(SocialUploadProfileImageLoading());
    // save the image with the last path segment
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then(
      (onValue) {
        emit(SocialUploadProfileImageSuccess());
        onValue.ref.getDownloadURL().then((onValue) {
          updateUserData(
            name: name,
            bio: bio,
            phone: phone,
            password: password,
            profile: onValue,
          );
        }).catchError((onError) {
          emit(SocialUploadProfileImageError());
        });
      },
    ).catchError(
      (onError) {
        emit(SocialUploadProfileImageError());
      },
    );
  }

  void uploadCoverImage({
    required String? name,
    required String? bio,
    required String? phone,
    required String? password,
  }) {
    emit(SocialUploadCoverImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then(
      (onValue) {
        emit(SocialUploadCoverImageSuccess());
        onValue.ref.getDownloadURL().then((onValue) {
          updateUserData(
            name: name,
            bio: bio,
            phone: phone,
            password: password,
            cover: onValue,
          );
        }).catchError((onError) {
          emit(SocialUploadCoverImageError());
        });
      },
    ).catchError(
      (onError) {
        emit(SocialUploadCoverImageError());
      },
    );
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialCreatePostImageSuccess());
    } else {
      debugPrint('No image selected');
      emit(SocialCreatePostImageError());
    }
  }

  void createPostWithImage({required String dateTime, required String text}) {
    emit(SocialCreatePostWithImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((onValue) {
      onValue.ref.getDownloadURL().then(
            (onValue) {
          createPost(
            postImage: onValue,
            dateTime: dateTime,
            text: text,
          );
          emit(SocialCreatePostWithImageSuccess());
        },
      ).catchError(
            (onError) {
          emit(SocialCreatePostWithImageError());
        },
      );
    }).catchError((onError) {
      emit(SocialCreatePostWithImageError());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoading());
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((onValue) {
      emit(SocialCreatePostSuccess());
    }).catchError((onError) {
      emit(SocialCreatePostError());
    });
  }

  void deleteImage(){
    postImage = null;
    emit(SocialCreatePostWithImageDelete());
  }
}
