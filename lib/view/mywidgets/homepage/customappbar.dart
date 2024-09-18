import 'package:flutter/material.dart';
import 'package:fyp/view/mycolors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String  title;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final List<Widget>? actions;
    const CustomAppbar({
    required this.title,
    this.centerTitle,
    this.actions,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
    
      title: Text(title),
      centerTitle: centerTitle??true,
      backgroundColor: angryFlamingo,
      foregroundColor: Colors.white,
      toolbarHeight: 85,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),

              bottom: bottom,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(85);
}