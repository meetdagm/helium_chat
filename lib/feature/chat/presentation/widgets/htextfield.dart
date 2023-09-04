import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helium_chat_application/helpers/base_colors.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';
import 'package:helium_chat_application/widgets/spacer_widgets.dart';

class HTextfield extends StatelessWidget {
  final String? fieldName;
  final String? hintText;
  final String placeholderText;
  final String? prefixText;
  final List<TextInputFormatter>? formatters;
  final Function(String)? onTextChange;
  final TextAlign textAlign;
  final bool isValueHidden;
  final TextEditingController? editingController;
  final String? errorMessage;
  final int? maxLines;
  final Widget? suffixWidget;
  final Color fillColor;
  final int? minLines;

  const HTextfield({
    super.key,
    this.fieldName,
    this.placeholderText = "",
    this.hintText,
    this.prefixText,
    this.formatters,
    this.onTextChange,
    this.isValueHidden = false,
    this.textAlign = TextAlign.start,
    this.errorMessage,
    this.editingController,
    this.maxLines = 1,
    this.suffixWidget,
    this.fillColor = BaseColors.white2,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 900,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (fieldName != null)
            Text(
              fieldName!,
              style: BaseFonts.body(
                color: BaseColors.grey2,
              ),
            ),
          if (fieldName != null) verticalMediumSpace,
          TextField(
            maxLines: maxLines,
            minLines: minLines,
            controller: editingController,
            obscureText: isValueHidden,
            onChanged: onTextChange,
            inputFormatters: formatters,
            textAlign: textAlign,
            style: BaseFonts.body(),
            cursorColor: BaseColors.black,
            cursorWidth: 1,
            scrollPadding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            decoration: InputDecoration(
              suffix: suffixWidget,
              filled: true,
              fillColor: fillColor,
              errorText: errorMessage,
              labelText: placeholderText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12,
              ),
              alignLabelWithHint: true,
              hintText: hintText,
              prefixText: prefixText,
              errorStyle: BaseFonts.caption(
                color: BaseColors.error,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: BaseColors.white3,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(21.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: BaseColors.error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(21.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: BaseColors.white3,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(21.0),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 100,
                borderSide: const BorderSide(
                  color: BaseColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(21.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
