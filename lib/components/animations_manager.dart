import 'package:flutter/material.dart';

enum AnimatedElementType {
  puzzleBoard,
}

class AnimatedElement<T> {
  final Tween<T> tween;
  final Duration duration;
  final Curve curve;

  AnimatedElement({
    required this.tween,
    required this.duration,
    required this.curve,
  });
}

class AnimationsManager {
  static final AnimatedElement<double> scaleUp = AnimatedElement<double>(
    duration: const Duration(milliseconds: 700),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeOutBack,
  );

  static final AnimatedElement<double> fadeIn = AnimatedElement<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeInOut,
  );

  static const Duration puzzleSolvedDialogDelay = Duration(milliseconds: 500);

  static const Duration bgLayerAnimationDuration = Duration(milliseconds: 600);

  static final AnimatedElement<double> tileHover = AnimatedElement<double>(
    duration: const Duration(milliseconds: 200),
    tween: Tween<double>(begin: 1, end: 0.94),
    curve: Curves.easeInOut,
  );

  static final AnimatedElement<double> pulse = AnimatedElement<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween<double>(begin: 1, end: 0.96),
    curve: Curves.easeInOut,
  );
}
