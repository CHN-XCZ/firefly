import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: const Color.fromARGB(255, 255, 255, 255), //主题色
    scaffoldBackgroundColor:
        const Color.fromARGB(255, 255, 255, 255), //整个页面（Scaffold）背景色
    appBarTheme: const AppBarTheme(color: Colors.black),
    extensions: const <ThemeExtension<dynamic>>[
      AppCustomTheme(
        customCardColor: Color(0xFFFFFFFF),
        cardRadius: 16.0,
        elevation: 4.0,
        borderColor: Color.fromARGB(50, 14, 14, 14),
      )
    ],
  );

  static final dark = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    primaryColor: const Color.fromARGB(255, 14, 14, 14),
    scaffoldBackgroundColor: const Color.fromARGB(255, 14, 14, 14),
    appBarTheme: const AppBarTheme(color: Colors.white),
    extensions: const <ThemeExtension<dynamic>>[
      AppCustomTheme(
        customCardColor: Color(0xFFFFFFFF),
        cardRadius: 16.0,
        elevation: 4.0,
        borderColor: Color.fromARGB(50, 232, 232, 232),
      )
    ],
  );
}

@immutable
class AppCustomTheme extends ThemeExtension<AppCustomTheme> {
  final Color customCardColor;
  final double cardRadius;
  final double elevation;
  final Color borderColor;

  const AppCustomTheme({
    required this.customCardColor,
    required this.cardRadius,
    required this.elevation,
    required this.borderColor,
  });

  @override
  AppCustomTheme copyWith({
    Color? customCardColor,
    double? cardRadius,
    double? elevation,
    Color? borderColor,
  }) {
    return AppCustomTheme(
      customCardColor: customCardColor ?? this.customCardColor,
      cardRadius: cardRadius ?? this.cardRadius,
      elevation: elevation ?? this.elevation,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  AppCustomTheme lerp(ThemeExtension<AppCustomTheme>? other, double t) {
    if (other is! AppCustomTheme) return this;
    return AppCustomTheme(
      customCardColor: Color.lerp(customCardColor, other.customCardColor, t)!,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t)!,
      elevation: lerpDouble(elevation, other.elevation, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }
}

AppCustomTheme getCustomTheme(BuildContext context) {
  return Theme.of(context).extension<AppCustomTheme>() ??
      const AppCustomTheme(
        customCardColor: Colors.white,
        cardRadius: 12.0,
        elevation: 2.0,
        borderColor: Colors.grey,
      );
}
