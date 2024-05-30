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
        if (kDebugMode) {
          print("send OTP....");
        }
        phone = event.phone;
        emit(OtpLoadingState());
        if (event.phone == '' || event.phone.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}authenticate/req-app-otp'),
            body: jsonEncode({
              "phone": removeCountryCode(event.phone),
              "appSignature": event.signature,
            }),
            headers: {"content-type": "application/json"},
          );

          if (kDebugMode) {
            print(response.statusCode);
            print(response.body);
          }

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
        if (kDebugMode) {
          print("login....");
          print(otp);
        }
        emit(LoginLoadingState());
        if (otp == '' || otp.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}authenticate/verify-app-otp'),
            body: jsonEncode({
              "otp": otp,
              "phone": removeCountryCode(phone),
            }),
            headers: {"content-type": "application/json"},
          );

          if (kDebugMode) {
            print(response.statusCode);
            print(response.body);
          }

          if (response.statusCode == 201) {
            // Login Success

            Map<String, dynamic> responseData = json.decode(response.body);

            if (responseData.containsKey('data')) {
              if (responseData['data']['success'] == false) {
                if (kDebugMode) {
                  print("falsee...");
                  print(responseData);
                  print(responseData['data']['success']);
                }

                emit(LoginErrorState(
                    error:
                        responseData['data']['message'] ?? 'Something Wrong!'));
              }
            } else {
              if (kDebugMode) {
                print("resssss...");
              }
              // It has sometimes multiple profile available for the same number
              //Handle it properly
              SharedPreferences prefs = await SharedPreferences.getInstance();

              final result = userLoginModelFromJson(response.body);

              // Getting the token

              final authHeader = response.headers['authorization'];

              if (kDebugMode) {
                print(authHeader);
              }
              // print(response.headers);

              if (authHeader != null) {
                final token = authHeader
                    .split(' ')
                    .last; // Split the header value and take the last part

                prefs.setString("token", token);

                if (kDebugMode) {
                  print('Token: $token');
                } // Now you have the token
              } else {
                if (kDebugMode) {
                  print('No authorization header found.');
                }
              }

              if (result.user!.length > 1) {
                //for multiple accounts
                // show a popup to choose the desired account
                for (var element in result.user!) {
                  if (kDebugMode) {
                    print(element.name);
                  }
                }
              } else {
                // only one account
                prefs.setString("phone", phone);
                //store the values to shared preferences
                prefs.setString("name", result.user!.first.name ?? '');
                prefs.setString("address", result.user!.first.paddress ?? '');
                prefs.setString("email", result.user!.first.pemail ?? '');
                prefs.setString("jobInfo", result.user!.first.jobInfo ?? '');
                prefs.setString(
                    "manager", result.user!.first.managerName ?? '');
                prefs.setString("team", result.user!.first.teams ?? '');
                prefs.setString("image", result.user!.first.pimage ?? '');
                prefs.setString("userId", result.user!.first.id ?? '');
              }

              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString("name", responseData['user'][0]['name']);

              emit(LoginSuccessState());
              // emit(LoginErrorState(error: response.body));
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
          if (kDebugMode) {
            print("Error: $e");
          }
          emit(LoginErrorState(error: e.toString()));
        }
      }
    });
  }

  String removeCountryCode(String phoneNumber) {
    // Check if the phone number starts with '+'
    if (phoneNumber.startsWith('+')) {
      // Remove the '+' sign and the next 2 characters (ISO 3166-1 alpha-2 code)
      if (kDebugMode) {
        print("With +");
      }
      return phoneNumber.substring(3);
    } else {
      if (kDebugMode) {
        print("No +");
      }
      // If the phone number doesn't start with '+', it might already be without the country code
      return phoneNumber;
    }
  }
}
