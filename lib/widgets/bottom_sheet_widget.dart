import 'package:fish/theme.dart';
import 'package:fish/widgets/max_width_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget {
  static getBottomSheetWidget(BuildContext context, List<Widget> children,
      {Function()? onClose}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.8),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              if (onClose != null) {
                onClose();
              }
              return true;
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: MaxWidthWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: paddingL),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: paddingXS,
                          width: padding6XL,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(padding8XL),
                            color: backgroundColor1,
                          ),
                        ),
                        const SizedBox(
                          height: paddingM,
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: paddingXL,
                            ),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(paddingL),
                                  topRight: Radius.circular(paddingL)),
                              color: backgroundColor1,
                            ),
                            child: SafeArea(
                              child: ListView(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                padding: EdgeInsets.only(
                                    left: paddingXL,
                                    right: paddingXL,
                                    bottom: paddingXL +
                                        MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                children: children,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
