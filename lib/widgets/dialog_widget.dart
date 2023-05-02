import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class DialogWidget {
  static open(BuildContext context, List<Widget> data) {
    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(padding2XL),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(paddingL),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView(
                        padding: const EdgeInsets.all(paddingXL),
                        shrinkWrap: true,
                        children: data,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
