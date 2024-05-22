import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/api/api.dart';
import '../../db/models/user_login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String phone = '';
  String otp = '';

  LoginBloc() : super(LoginInitial()) {
    on<PhoneChangeEvent>((event, emit) {
      phone = event.phone;
    });

    on<OtpChangeEvent>((event, emit) {
      otp = event.otp;
    });

    //send otp
    on<VerifyOtpBtnClickEvent>((event, emit) async {
      try {
        print("send OTP....");
        emit(OtpLoadingState());
        if (phone == '' || phone.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}attendance-app/req-otp'),
            body: jsonEncode({
              "phone": removeCountryCode(phone),
            }),
            headers: {"content-type": "application/json"},
          );

          print(response.statusCode);
          print(response.body);

          //TODO: otp sending response handling
          if (response.statusCode == 201) {
            // OTP SEND Success
            Map<String, dynamic> responseData = json.decode(response.body);
            if (kDebugMode) {
              print(responseData);
            }

            if (responseData['data']['success'] == true) {
              emit(OtpSuccessState());
            } else if (responseData['data']['success'] == false) {
              emit(OtpErrorState(error: responseData['data']['message']));
              // emit(OtpErrorState(error: responseData['data']['error']));
            } else {
              emit(OtpErrorState(error: response.body));
            }
          } else {
            emit(OtpErrorState(error: response.body));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (e.toString().contains("Connection timed out")) {
          emit(OtpErrorState(error: "Connection timed out"));
        } else if (e.toString().contains("No route to host")) {
          emit(OtpErrorState(error: "No route to host"));
        } else {
          emit(OtpErrorState(error: e.toString()));
        }
      }
    });

    // verify otp and login
    on<LoginBtnClickEvent>((event, emit) async {
      try {
        print("login....");
        emit(LoginLoadingState());
        if (otp == '' || otp.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}attendance-app/login'),
            body: jsonEncode({
              "otp": otp,
              "phone": removeCountryCode(phone),
            }),
            headers: {"content-type": "application/json"},
          );

          print(response.statusCode);
          print(response.body);

          if (response.statusCode == 201) {
            // Login Success

            Map<String, dynamic> responseData = json.decode(response.body);

            if (responseData['data']['success'] == false) {
              emit(LoginErrorState(
                  error: responseData['data']['message'] ?? 'Something Wrong!'));
            } else {
              // TODO: success section
              // It has sometimes multiple profile available for the same number
              //Handle it properly
              SharedPreferences prefs = await SharedPreferences.getInstance();

              final result = userLoginModelFromJson(response.body);

              if (result.data!.user!.length > 1) {
                //for multiple accounts
                // show a popup to choose the desired account
                for (var element in result.data!.user!) {
                  if (kDebugMode) {
                    print(element.name);
                  }
                }
              } else {
                // only one account
                prefs.setString("phone", phone);
                //store the values to shared preferences
                prefs.setString("name", result.data!.user!.first.name ?? '');
                prefs.setString("address", result.data!.user!.first.paddress ?? '');
                prefs.setString("email", result.data!.user!.first.pemail ?? '');
                prefs.setString("jobInfo", result.data!.user!.first.jobInfo ?? '');
                prefs.setString(
                    "manager", result.data!.user!.first.managerName ?? '');
                prefs.setString("team", result.data!.user!.first.teams ?? '');
                prefs.setString("image", result.data!.user!.first.pimage ?? '');
                prefs.setString("userId", result.data!.user!.first.id ?? '');
              }

              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString("name", responseData['user'][0]['name']);

              emit(LoginSuccessState());
            }
          } else {
            emit(LoginErrorState(error: response.body));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (e.toString().contains("Connection timed out")) {
          emit(LoginErrorState(error: "Connection timed out"));
        } else if (e.toString().contains("No route to host")) {
          emit(LoginErrorState(error: "No route to host"));
        } else {
          emit(LoginErrorState(error: e.toString()));
        }
      }
    });
  }

  String removeCountryCode(String phoneNumber) {
    // Check if the phone number starts with '+'
    if (phoneNumber.startsWith('+')) {
      // Remove the '+' sign and the next 2 characters (ISO 3166-1 alpha-2 code)
      print("With +");
      return phoneNumber.substring(3);
    } else {
      print("No +");
      // If the phone number doesn't start with '+', it might already be without the country code
      return phoneNumber;
    }
  }
}
