import 'package:flutter/material.dart';

class MaxWidthWidget extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const MaxWidthWidget({Key? key, required this.child, this.maxWidth = 600})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ));
  }
}
