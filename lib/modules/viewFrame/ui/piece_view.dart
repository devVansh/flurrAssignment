import 'package:flutter/material.dart';
import '../../../utils/floating_widget.dart';

class PieceView extends StatefulWidget {
  final Widget image;
  final Function bringToTop;

  const PieceView({
    Key? key,
    required this.image,
    required this.bringToTop,
  }) : super(key: key);

  @override
  PuzzlePieceState createState() {
    return PuzzlePieceState();
  }
}

class PuzzlePieceState extends State<PieceView> {
  @override
  Widget build(BuildContext context) {
    return FloatingWidget(
      child: widget.image,
      voidCallback: () {
        widget.bringToTop(widget);
      },
    );
  }
}
