import 'package:fish/theme.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.label,
    this.isLong = true,
    this.isEdit = true,
    this.isMoreText = false,
    required this.controller,
    this.hint,
    this.suffixSection,
    this.prefixSection,
    this.numberOutput = false,
    this.isHintStyle = false,
    this.styleHint,
    this.isEnableSwitch = false,
    this.switchValue = true,
    this.switchOnChange,
    this.onChange,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? hint;
  final Widget? suffixSection, prefixSection;
  final bool isLong,
      isEdit,
      isMoreText,
      numberOutput,
      isHintStyle,
      isEnableSwitch,
      switchValue;
  final TextStyle? styleHint;
  final Function(bool)? switchOnChange;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: headingText2,
              textAlign: TextAlign.left,
            ),
            isEnableSwitch
                ? Switch(
                    value: switchValue,
                    onChanged: switchOnChange,
                  )
                : Container(),
          ],
        ),
        isEnableSwitch && switchValue
            ? Container()
            : SizedBox(
                height: 12,
              ),
        switchValue
            ? Column(
                children: [
                  Container(
                    width: isLong
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.7,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isEdit ? inputColor : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: isEdit ? transparentColor : backgroundColor2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        prefixSection != null
                            ? Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: prefixSection,
                              )
                            : const SizedBox(),
                        Expanded(
                          child: TextFormField(
                            onChanged: onChange,
                            minLines: isMoreText ? 5 : null,
                            maxLines: isMoreText ? null : 1,
                            controller: controller,
                            style: headingText3,
                            enabled: isEdit,
                            keyboardType: numberOutput
                                ? TextInputType.number
                                : TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hint,
                              hintStyle: isHintStyle ? styleHint : hoverText,
                            ),
                          ),
                        ),
                        suffixSection != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: suffixSection,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
