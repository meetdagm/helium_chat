import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/base_colors.dart';
import '../helpers/base_fonts.dart';

class BusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;
  final double padding;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const BusyButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.busy = false,
    this.padding = 0.0,
    this.height = 45,
    this.backgroundColor = BaseColors.primary,
    this.textColor = BaseColors.white,
    this.enabled = false,
  });

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        widget.padding,
      ),
      child: SizedBox(
        height: widget.height,
        child: InkWell(
          onTap: () => widget.onPressed(),
          mouseCursor:
              widget.enabled ? MaterialStateMouseCursor.clickable : null,
          child: AnimatedContainer(
            height: widget.busy ? 40 : 0,
            // width: widget.busy ? 40 : null,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: widget.enabled
                  ? widget.backgroundColor
                  : BaseColors.primary100,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: !widget.busy
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: AutoSizeText(
                      widget.title,
                      style: BaseFonts.body(
                        color: widget.textColor,
                        fontSize: 16,
                      ),
                    ),
                  )
                : const CupertinoActivityIndicator(
                    color: BaseColors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
