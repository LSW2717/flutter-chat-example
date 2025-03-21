import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'objectbox.g.dart';


late final Store store;

Future<void> mainInitializer() async {

  WidgetsFlutterBinding.ensureInitialized();

  //if you use http
  HttpOverrides.global =  MyHttpOverrides();

  await dotenv.load(fileName: '.env');

  await initializeDateFormatting('ko_KR', null);

  // if you need localStorage
  store = await openStore();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}