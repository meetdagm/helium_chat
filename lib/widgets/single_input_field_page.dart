import 'package:flutter/material.dart';

import '../helpers/base_colors.dart';
import '../helpers/base_fonts.dart';
import 'busy_button.dart';
import 'spacer_widgets.dart';
import 'teritiary_button.dart';

class SingleInputFieldPage extends StatelessWidget {
  final TextEditingController _editingController;
  final String headline;
  final bool isTextFieldEnabled;
  final String textFieldHintText;
  final Function(String) onTextChange;
  final bool isBusy;
  final bool isTextHidden;
  final String ctaText;
  final bool isCtaEnabled;
  final Function onCtaPressed;
  final bool hasSecondaryCta;
  final String? secondaryCtaText;
  final Function? onSecondaryCtaPressed;
  final int maxLines;

  const SingleInputFieldPage({
    super.key,
    required TextEditingController editingController,
    required this.headline,
    required this.isTextFieldEnabled,
    required this.textFieldHintText,
    required this.onTextChange,
    required this.isBusy,
    required this.ctaText,
    required this.isCtaEnabled,
    required this.onCtaPressed,
    this.hasSecondaryCta = false,
    this.secondaryCtaText,
    this.onSecondaryCtaPressed,
    this.isTextHidden = false,
    this.maxLines = 1,
  })  : _editingController = editingController,
        assert(
          hasSecondaryCta
              ? secondaryCtaText != null && onSecondaryCtaPressed != null
              : true,
          'If we need a secondary CTA make sure to include the title and onpressed function',
        ),
        assert(isTextHidden || maxLines == 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          verticalMediumSpace,
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                verticalMediumSpace,
                Text(
                  headline,
                  style: BaseFonts.headline(),
                  textAlign: TextAlign.center,
                ),
                verticalLargeSpace,
                TextField(
                  controller: _editingController,
                  autofocus: true,
                  enabled: isTextFieldEnabled,
                  style: BaseFonts.body(),
                  maxLines: maxLines,
                  obscureText: isTextHidden,
                  cursorColor: BaseColors.primary,
                  cursorHeight: 24,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: textFieldHintText,
                    hintStyle: BaseFonts.body(
                      color: BaseColors.grey,
                    ),
                    labelStyle: BaseFonts.body(),
                  ),
                  onChanged: (value) {
                    _editingController.value = TextEditingValue(
                      text: value,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    );
                    onTextChange(value);
                  },
                ),
              ],
            ),
          ),
          BusyButton(
            title: ctaText,
            busy: isBusy,
            enabled: isCtaEnabled,
            onPressed: onCtaPressed,
          ),
          verticalSmallSpace,
          if (hasSecondaryCta)
            TeritiaryButton(
              title: secondaryCtaText!,
              onPressed: () => onSecondaryCtaPressed!(),
            ),
        ],
      ),
    );
  }
}
