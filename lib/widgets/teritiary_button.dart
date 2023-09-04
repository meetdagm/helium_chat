import 'package:flutter/material.dart';

import '../helpers/base_colors.dart';
import '../helpers/base_fonts.dart';

class TeritiaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final TextAlign? textAlign;

  const TeritiaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 3.0,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        textAlign: textAlign,
        style: BaseFonts.body(
          color: BaseColors.secondary,
        ),
      ),
    );
  }
}
