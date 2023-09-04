import 'package:flutter/material.dart';
import 'package:helium_chat_application/helpers/base_colors.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';
import 'package:helium_chat_application/widgets/spacer_widgets.dart';

class ChatBubble extends StatelessWidget {
  final bool isOtherUser;
  final String text;
  final String sentAt;

  const ChatBubble({
    super.key,
    required this.isOtherUser,
    required this.text,
    required this.sentAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 7,
      ),
      alignment: isOtherUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isOtherUser ? BaseColors.white3 : BaseColors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              isOtherUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: BaseFonts.body(
                color: isOtherUser ? BaseColors.black : BaseColors.white,
              ),
            ),
            verticalTinySpace,
            Text(
              sentAt,
              style: BaseFonts.caption(
                color: isOtherUser ? BaseColors.black : BaseColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
