import 'package:flutter/material.dart';
import 'dart:math';

enum Palette {
  color1,
  color2,
  color3,
  color4,
  color5,
  color6,
}

extension PaletteExtension on Palette {
  Color get color {
    switch (this) {
      case Palette.color1:
        return const Color(0xffbfb2f3);
      case Palette.color2:
        return const Color(0xff96caf7);
      case Palette.color3:
        return const Color(0xff9cdcaa);
      case Palette.color4:
        return const Color(0xffe5e1ab);
      case Palette.color5:
        return const Color(0xfff3c6a5);
      case Palette.color6:
        return const Color(0xfff8a3a8);
    }
  }
}

extension GradientExtension on Palette {
  LinearGradient get gradient {
    switch (this) {
      case Palette.color1:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color1.color,
            Palette.color2.color,
          ],
        );
      case Palette.color2:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color2.color,
            Palette.color3.color,
          ],
        );
      case Palette.color3:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color3.color,
            Palette.color4.color,
          ],
        );
      case Palette.color4:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color4.color,
            Palette.color5.color,
          ],
        );
      case Palette.color5:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color5.color,
            Palette.color6.color,
          ],
        );
      case Palette.color6:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Palette.color6.color,
            Palette.color1.color,
          ],
        );
    }
  }
}

LinearGradient getRandomGradient(int index) {
  var rng = Random();
  int randomNumber = rng.nextInt(5);
  switch (randomNumber) {
    case 0:
      return Palette.color1.gradient;
    case 1:
      return Palette.color2.gradient;
    case 2:
      return Palette.color3.gradient;
    case 3:
      return Palette.color4.gradient;
    case 4:
      return Palette.color5.gradient;
    case 5:
      return Palette.color6.gradient;
    default:
      return Palette.color1.gradient;
  }
}
