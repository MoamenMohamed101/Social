import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/register/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({required String email, required String password}) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then(
          (onValue) {
            debugPrint(onValue.user!.email);
            debugPrint(onValue.user!.uid);
            emit(RegisterSuccess());
          },
        )
        .catchError(
          (onError) {
            debugPrint(onError.toString());
            emit(RegisterSuccess());
          },
        );
  }
}