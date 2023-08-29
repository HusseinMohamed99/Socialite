import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    debugPrint('dioHelper Initialized');
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key = AAAAHv5IYHw:APA91bFL7S1bvVb9PlK-fUdeSWWQQAiCEyckzYfmogaWGlkxLLtzK5LKCnPk4_imOygnahdkJF7c4bxBCt7FD-PQM2jotv9W_ou3lIUihfHetFxWWQptcDVzf9ziyXNQTX2R5BMZ1Imo '
    };
    return await dio.post(
      'https://fcm.googleapis.com/fcm/send',
      data: data,
    );
  }
}
