import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:provider/provider.dart';

import '../modules/viewFrame/provider/view_frame_provider.dart';

class FloatingWidget extends StatefulWidget {
  final Widget child;
  final Function voidCallback;

  const FloatingWidget(
      {Key? key, required this.child, required this.voidCallback})
      : super(key: key);

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget> {
  Matrix4 _transform = Matrix4.identity();

  @override
  Widget build(BuildContext context) => Consumer<ViewFrameProvider>(
      builder: (c, ViewFrameProvider viewFrameProvider, _) =>
          Builder(builder: (context) {
            return Transform(
              transform: _transform,
              child: MatrixGestureDetector(
                onMatrixUpdate: (matrix, translationDeltaMatrix,
                    scaleDeltaMatrix, rotationDeltaMatrix) {
                  setState(() {
                    _transform = matrix;
                  });

                  widget.voidCallback();
                },
                child: widget.child,
              ),
            );
          }));
}
