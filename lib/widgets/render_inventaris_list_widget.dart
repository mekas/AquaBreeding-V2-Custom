import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class RenderInventarisListWidget extends StatelessWidget {
  const RenderInventarisListWidget(
      {Key? key, required this.dataLength, required this.child})
      : super(key: key);

  final Widget child;
  final int dataLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: padding4XL),
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              borderRadius: BorderRadius.circular(14),
            ),
            child: child,
          );
        }),
        itemCount: dataLength,
      ),
    );
  }
}
