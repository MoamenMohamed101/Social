abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginChangePasswordIcon extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
