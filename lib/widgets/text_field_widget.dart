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
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool isLong;
  final String? hint;
  final Widget? suffixSection, prefixSection;
  final bool isEdit;
  final bool isMoreText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: headingText2,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: isLong
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2.8,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: inputColor,
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
                  minLines: isMoreText ? 5 : null,
                  maxLines: isMoreText ? null : 1,
                  controller: controller,
                  style: headingText3,
                  enabled: isEdit,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: hoverText,
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
    );
  }
}
