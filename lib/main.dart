import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instx/instx_app.dart';

Future<void> main() async {
  final dio = Dio();
  runApp(InstxApp(
    dio: dio,
  ));
}
