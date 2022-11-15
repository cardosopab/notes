import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pantallas/pantalla_home.dart';

void main() {
  // if (kIsWeb) {
  //   runApp(const ProviderScope(child: Center(child: SizedBox(width: 400, height: 800, child: MyApp()))));
  // } else {
  runApp(const ProviderScope(child: MyApp()));
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notas',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff76504E),
        ),
        scaffoldBackgroundColor: const Color(0xff86736C),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xff76504E),
        ),
        textButtonTheme: const TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white))),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xff76504E),
        ),
      ),
      home: const PantallaHome(),
    );
  }
}
