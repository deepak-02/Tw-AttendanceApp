part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class PhoneChangeEvent extends LoginEvent {
  final String phone;

  PhoneChangeEvent({required this.phone});
}

class LoginBtnClickEvent extends LoginEvent {}

// otp section

class OtpChangeEvent extends LoginEvent {
  final String otp;

  OtpChangeEvent({required this.otp});
}

class VerifyOtpBtnClickEvent extends LoginEvent {
  final String signature;
  final String phone;

  VerifyOtpBtnClickEvent({required this.phone, required this.signature});
}
