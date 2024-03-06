import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/bloc_observer.dart';
import 'package:instx/domain/config/firebase_options.dart';
import 'package:instx/instx_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dio = Dio();
  Bloc.observer = SimpleBlocObserver();
  runApp(InstxApp(
    dio: dio,
  ));
}
