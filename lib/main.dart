

import 'package:bubbletown_v1/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

// String a =  readPreference("bubbletownToken");

// Network Image: Exception caught by image resource service
// I figured out how to limit the connections on the underlying HttpClient of NetworkImage!
// I globally overrode the HttpClient:
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 15;
  }
}

void main() {
  debugPaintSizeEnabled = false;
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          const Locale('en', 'US'), // American English
          const Locale('es', 'MX'), // Español México
          // ...
        ],
        title: 'BubbleApp',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: 'Nunito',
        ),
        home: LoginPage());
  }
}
