import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/api/api.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String phone = prefs.getString('phone') ?? '';
        // Use Dio for the API call
        final response = await dio.get(
          '${api}workluge-app/get-profile/${removeCountryCode(phone)}',
          // data: {
          //   "phone": removeCountryCode(phone),
          // },
          options: Options(headers: {
            "content-type": "application/json",
            // 'Authorization': 'Bearer $testToken',
          }),
        );

        if (kDebugMode) {
          print(response.headers);
          print(response.statusCode);
          print(response.data);
        }

        if (response.statusCode == 201) {
          if (response.data['data']['success'] == true) {
            // final result = profileModelFromJson("${response.data}");

            if (kDebugMode) {
              print(response.data['data']);
              print("......................");
              print(response.data['data']['user'][0]['name']);
              print(response.data['data']['user'][0]['paddress']);
              print(response.data['data']['user'][0]['pemail']);
              print(response.data['data']['user'][0]['jobInfo']);
              print(response.data['data']['user'][0]['managerName']);
              print(response.data['data']['user'][0]['teams']);
              print(response.data['data']['user'][0]['pimage']);
              print(response.data['data']['user'][0]['_id']);
            }

            prefs.setString(
                "name", response.data['data']['user'][0]['name'] ?? '');
            prefs.setString(
                "address", response.data['data']['user'][0]['paddress'] ?? '');
            prefs.setString(
                "email", response.data['data']['user'][0]['pemail'] ?? '');
            prefs.setString(
                "jobInfo", response.data['data']['user'][0]['jobInfo'] ?? '');
            prefs.setString("manager",
                response.data['data']['user'][0]['managerName'] ?? '');
            prefs.setString(
                "team", response.data['data']['user'][0]['teams'] ?? '');
            prefs.setString(
                "image", response.data['data']['user'][0]['pimage'] ?? '');
            prefs.setString(
                "userId", response.data['data']['user'][0]['_id'] ?? '');

            emit(ProfileSuccessState());
          } else if (response.data['data']['success'] == false) {
            emit(ProfileErrorState(error: response.data['data']['message']));
            // emit(OtpErrorState(error: responseData['data']['error']));
          } else {
            emit(ProfileErrorState(error: response.data));
          }
        } else if (response.statusCode == 200) {
          if (response.data['error'] == "UnauthorizedError") {
            emit(ProfileErrorState(error: response.data['message']));
          }
        } else {
          emit(ProfileErrorState(error: response.data));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (e.toString().contains("Connection timed out")) {
          emit(ProfileErrorState(error: "Connection timed out"));
        } else if (e.toString().contains("No route to host")) {
          emit(ProfileErrorState(error: "No route to host"));
        } else {
          emit(ProfileErrorState(error: e.toString()));
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
