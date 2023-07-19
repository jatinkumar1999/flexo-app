import 'package:flutter/material.dart';

import 'constant/color_constant.dart';

class MyAppBarPage extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? icon;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  MyAppBarPage({
    this.title,
    this.icon,
    this.actions,
    this.onPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  AppColor.orangeColor,
      title: Text(
        title!,
        style: TextStyle(color: Colors.white),
      ),

      //centerTitle: true,
      /* leading: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ), */

    );
  }

}
