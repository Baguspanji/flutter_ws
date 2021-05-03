import 'package:flutter/material.dart';

class Colorses {
  final Color dasar = Color(0xff45756B);
  final Color kuning = Color(0xFFF1AF2F);
  final Color merah = Color(0xFFd44b42);
  final Color background = Color(0xFFD0EDBF);
  // final List<Color> gradient = [Color(0xff9C1511), Colors.red];
  static Map<int, Color> color = {
    50: Color.fromRGBO(69, 117, 107, .1),
    100: Color.fromRGBO(69, 117, 107, .2),
    200: Color.fromRGBO(69, 117, 107, .3),
    300: Color.fromRGBO(69, 117, 107, .4),
    400: Color.fromRGBO(69, 117, 107, .5),
    500: Color.fromRGBO(69, 117, 107, .6),
    600: Color.fromRGBO(69, 117, 107, .7),
    700: Color.fromRGBO(69, 117, 107, .8),
    800: Color.fromRGBO(69, 117, 107, .9),
    900: Color.fromRGBO(69, 117, 107, 1),
  };

  MaterialColor colorCustom = MaterialColor(0xff45756B, color);
}

final colorses = Colorses();
