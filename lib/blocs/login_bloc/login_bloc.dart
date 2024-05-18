import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/api/api.dart';
import 'package:http/http.dart' as http;

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
        emit(OtpLoadingState());
        if (phone == '' || phone.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}attendance-app/send-otp'),
            body: jsonEncode({
              "phone": phone,
            }),
            headers: {"content-type": "application/json"},
          );

          //TODO: otp sending response handling
          if (response.statusCode == 200) {
            // Login Success

            Map<String, dynamic> responseData = json.decode(response.body);
            if (kDebugMode) {
              print(responseData);
            }
            emit(OtpSuccessState());

          } else {
            emit(OtpErrorState(error: response.body));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(OtpErrorState(error: e.toString()));
      }
    });

    // verify otp and login
    on<LoginBtnClickEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        if (otp == '' || otp.isEmpty) {
          emit(EmptyFieldsState());
          return;
        } else {
          final response = await http.post(
            Uri.parse('${api}attendance-app/login'),
            body: jsonEncode({
              "otp": otp,
              "phone": phone,
            }),
            headers: {"content-type": "application/json"},
          );

          if (response.statusCode == 200) {
            // Login Success

            Map<String, dynamic> responseData = json.decode(response.body);

            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString("name", responseData['name']);
            // prefs.setString("email", email);
            // prefs.setString("batch", responseData['batch']);
            // prefs.setString("role", responseData['role']);

            if (responseData['success'] == false) {
              if (responseData['message'] == "User not found") {
                emit(NoUserFoundState());
              } else {
                emit(LoginErrorState(
                    error: responseData['message'] ?? 'Something Wrong!'));
              }
            } else {
              // TODO: success section
              // It has sometimes multiple profile available for the same number
              //Handle it properly
              SharedPreferences prefs = await SharedPreferences.getInstance();

              final result = userLoginFromJson(response.body);

              if(result.user!.length > 1){
                //for multiple accounts
                // show a popup to choose the desired account
                for (var element in result.user!) {
                  if (kDebugMode) {
                    print(element.name);
                  }
                }
              }else{
                // only one account
                //store the values to shared preferences
                prefs.setString("name", result.user!.first.name ?? '');
                prefs.setString("address", result.user!.first.paddress ?? '');
                prefs.setString("email", result.user!.first.pemail ?? '');
                prefs.setString("jobInfo", result.user!.first.jobInfo ?? '');
                prefs.setString("manager", result.user!.first.managerName ?? '');
                prefs.setString("team", result.user!.first.teams ?? '');
                prefs.setString("image", result.user!.first.pimage ?? '');
                prefs.setString("userId", result.user!.first.id ?? '');

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
        emit(LoginErrorState(error: e.toString()));
      }
    });
  }
}
