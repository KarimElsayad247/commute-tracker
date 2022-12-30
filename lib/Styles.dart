import 'package:flutter/material.dart';

class Styles {
  static const mediumFont = TextStyle(fontSize: 16);
  static const largerFont = TextStyle(fontSize: 18);
  static const largeFont = TextStyle(fontSize: 20);
  static const gigaFont = TextStyle(fontSize: 24);

  static const backgroundGray = Color(0xFFeeeeee);

  static ButtonStyle veryBigButton(Color backgroundColor) {
    return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: const Size(300, 60),
      primary: backgroundColor,
    );
  }
}
