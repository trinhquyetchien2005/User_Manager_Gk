
import 'package:flutter/material.dart';

class Animations {
  static Widget fadeIn({required Widget child, Duration duration = const Duration(milliseconds: 500)}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      builder: (context, value, childWidget) => Opacity(opacity: value, child: childWidget),
      child: child,
    );
  }

  static Widget slideUp({required Widget child, Duration duration = const Duration(milliseconds: 500)}) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(0, 0.3), end: Offset.zero),
      duration: duration,
      builder: (context, offset, childWidget) => Transform.translate(offset: Offset(0, offset.dy * 100), child: childWidget),
      child: child,
    );
  }
}
