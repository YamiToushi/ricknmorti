import 'package:flutter/material.dart';

class AppColors {
  static final lightColors = _Colors(
    primary: Color(0xFF6200EE),
    secondary: Color(0xFF03DAC6),
    background: Color(0xFFF5F5F5),
    text: Color(0xFF000000),
    accent: Color(0xFFFF5722),
  );

  static final darkColors = _Colors(
    primary: Color(0xFFBB86FC),
    secondary: Color(0xFF03DAC6),
    background: Color(0xFF121212),
    text: Color(0xFFFFFFFF),
    accent: Color(0xFFFF5722),
  );
}

class _Colors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color accent;

  _Colors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.accent,
  });
}
