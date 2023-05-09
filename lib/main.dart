import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/constants/colors.dart';
import 'screens/home.dart';

void main() {
  if (kIsWeb) {
    runApp(const ProviderScope(child: Center(child: SizedBox(width: 400, height: 800, child: NoteApp()))));
  } else {
    runApp(const ProviderScope(child: NoteApp()));
  }
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Constants().chocolate,
        ),
        scaffoldBackgroundColor: Constants().lightBrown,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white54),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Constants().chocolate,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Constants().chocolate,
        ),
      ),
      home: const Home(),
    );
  }
}
