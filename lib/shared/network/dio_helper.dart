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
          'key = AAAAqnVMlS0:APA91bHd_ooZwkN81g8c0xaDHC0KPN1QrRhVcq_qG4MZ1pvciG6MF4MhiMDY1HnrscPQeONN_mgEOQl1eU80jZ2NgvYGJKTon8CJ2nLIxwGgkwNBtYhFEDhPYo3sYpXpeYzITVfDo9nT'
    };
    return await dio.post(
      'https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send',
      data: data,
    );
  }
}
