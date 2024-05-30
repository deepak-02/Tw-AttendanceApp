import 'package:dio/dio.dart';

String api = 'http://192.168.1.51:5000/';

Dio dio = Dio(
  BaseOptions(
    baseUrl: api, // Set your base URL here
    // connectTimeout: const Duration(seconds: 30),
    // receiveTimeout: const Duration(seconds: 30),
  ),
);
