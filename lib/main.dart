import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as nav;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendance/screens/login/login_page.dart';
import 'package:attendance/screens/otherScreens/splash_screen.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'package:dio/dio.dart';

import 'blocs/profile_bloc/profile_bloc.dart';
import 'db/api/api.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (kDebugMode) {
          print("Request intercepted");
        }
        // Before sending the request, add the Authorization header with the token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString(
            "token"); // Implement this function to retrieve the token
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        if (kDebugMode) {
          print("option : ${options.headers}");
        }

        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) async {
        if (kDebugMode) {
          print("Response : ${response.data}");
        }
        // Map<String, dynamic> responseData = json.decode(response.data.toString());
        // response.data.toString().contains("Token is Expired")
        if (response.data['error'] == 'TokenExpiredError') {
          // Display a SnackBar
          const snackBar = SnackBar(
              content: Text('Your session has expired. Please log in again.'));
          scaffoldMessengerKey.currentState!.showSnackBar(snackBar);

          Future.delayed(const Duration(seconds: 2), () async {
            if (kDebugMode) {
              print("Clearing...");
            }
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            nav.Get.offAll(
              const LoginPage(),
              transition: nav.Transition.circularReveal,
              duration: const Duration(milliseconds: 800),
            );
          });
        }
        // Handle the error as needed, similar to how you would in onError
        // For example, navigate to a login screen or show an error message
        // }
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (kDebugMode) {
          print("Error intercepted");
          print("Error: $e");
          print("expiree....");
        }

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        // nav.Get.offAll(
        //   const LoginPage(),
        //   transition: nav.Transition.circularReveal,
        //   duration: const Duration(milliseconds: 800),
        // );
        return handler.next(e); // Pass the error along if nothing was done
      },
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: nav.GetMaterialApp(
        title: 'Attendance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff21206a)),
          useMaterial3: true,
        ),
        // home: TestFile(),
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: const SplashScreen(),
      ),
    );
  }
}
