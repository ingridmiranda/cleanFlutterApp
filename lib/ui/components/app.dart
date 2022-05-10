import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
        title: '4dev',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: primaryColor,
            primaryColorDark: primaryColorDark,
            primaryColorLight: primaryColorLight,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
            backgroundColor: Colors.white,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColorDark),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColorLight)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(color: primaryColorLight),
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return primaryColorLight;
                } else {
                  return primaryColor;
                }
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white),
              padding: MaterialStateProperty.resolveWith(
                (states) =>
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            )),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return primaryColorLight;
                } else {
                  return primaryColor;
                }
              }),
              foregroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white),
              padding: MaterialStateProperty.resolveWith(
                (states) =>
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            )),
            buttonTheme: ButtonThemeData(
                colorScheme: const ColorScheme.light(primary: primaryColor),
                buttonColor: primaryColor,
                splashColor: primaryColorLight,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: const LoginPage());
  }
}
