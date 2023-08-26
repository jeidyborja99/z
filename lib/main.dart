import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z/pages/powerPage.dart';
import 'package:z/pages/reservas/listar.dart';
import 'package:z/splash_screen.dart';
import 'package:z/views/nav/nav.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Cambio en el widget raíz
      debugShowCheckedModeBanner: false,
      title: 'FunHotel',
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/loginPage': (BuildContext context) => const SplashScreen(),
        '/power': (BuildContext context) => const Power(),
        '/nav': (BuildContext context) => const PersistentBottonNavBar(),
        '/listarReserva': (BuildContext context) => const ListarReserva(),
      },
    );
  }
}
