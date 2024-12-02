abstract class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class CreateUserSuccess extends RegisterState {}

final class CreateUserError extends RegisterState {}

final class RegisterError extends RegisterState {}
