part of 'login_register_cubit.dart';

@immutable
abstract class LoginRegisterState {}

class LoginRegisterInitial extends LoginRegisterState {}
class RegisterLoading extends LoginRegisterState {}
class RegisterSuccess extends LoginRegisterState {}
class RegisterFailure extends LoginRegisterState {
  final String errorMessage;

  RegisterFailure(this.errorMessage);
}

class LoginLoading extends LoginRegisterState{}
class LoginSuccess extends LoginRegisterState{}
class LoginFailure extends LoginRegisterState{
  final String errorMessage;
  LoginFailure(this.errorMessage);
}
class CheckVisibility extends LoginRegisterState{}
