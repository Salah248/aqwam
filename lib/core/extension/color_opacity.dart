import 'package:flutter/widgets.dart';

extension ColorOpacity on Color {
  Color colorOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
