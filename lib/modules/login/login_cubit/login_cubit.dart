import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = false;

  void changeIcon() {
    isPassword = !isPassword;
    emit(LoginChangePasswordIcon());
  }

  void loginUser({required String email, required String password}) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((onValue) {
      emit(LoginSuccess());
    }).catchError((onError) {
      emit(LoginError(onError.toString()));
      debugPrint(onError.toString());
    });
  }
}
