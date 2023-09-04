import 'package:flutter/material.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';

class MessagePreviewWidget extends StatelessWidget {
  final String title;
  final String description;
  final String timeStamp;
  final Function onTap;

  const MessagePreviewWidget({
    super.key,
    required this.title,
    required this.description,
    required this.timeStamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: BaseFonts.headline3(),
                  ),
                ),
                Text(
                  timeStamp,
                  style: BaseFonts.caption(),
                ),
              ],
            ),
            Text(
              description,
              style: BaseFonts.body(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
