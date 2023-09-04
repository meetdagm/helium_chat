import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? trailing;
  final Color? backgroundColor;

  const Screen({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: trailing != null ? [trailing!] : null,
        leading: canPop
            ? IconButton(
                icon: const Icon(
                  CupertinoIcons.chevron_back,
                ),
                iconSize: 30,
                color: Colors.black,
                onPressed: () {
                  locator<NavigationService>().pop();
                },
              )
            : null,
        title: title != null
            ? Text(
                title!,
                style: BaseFonts.headline2(),
              )
            : null,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
