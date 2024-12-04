import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/register/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (onValue) {
        createUser(
          email: email,
          password: password,
          phone: phone,
          name: name,
          uId: onValue.user!.uid,
        );
        emit(RegisterSuccess());
      },
    ).catchError(
      (onError) {
        debugPrint(onError.toString());
        emit(RegisterSuccess());
      },
    );
  }

  void createUser({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      email,
      name,
      phone,
      password,
      'https://i.sstatic.net/l60Hf.png',
      'write your bio ...',
      'https://marketplace.canva.com/EAEmBit3KfU/1/0/1600w/canva-black-flatlay-photo-motivational-finance-quote-facebook-cover-myVl9DXwcjQ.jpg',
      uId,
      false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((onValue) {
      emit(CreateUserSuccess());
    }).catchError((onError) {
      emit(CreateUserError());
    });
  }
}
