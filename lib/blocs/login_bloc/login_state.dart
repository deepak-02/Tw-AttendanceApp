part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class NoUserFoundState extends LoginState {}

class EmptyFieldsState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

class LoginLoadingState extends LoginState {}

class OtpLoadingState extends LoginState {}

class OtpErrorState extends LoginState {
  final String error;

  OtpErrorState({required this.error});
}

class OtpSuccessState extends LoginState {}

class OtpResendState extends LoginState {}

class LoginSuccessState extends LoginState {}
