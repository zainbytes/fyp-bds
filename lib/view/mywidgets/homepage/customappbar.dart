import 'package:flutter/material.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:google_fonts/google_fonts.dart';

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
    
      title: FittedBox(child: Text(title,style: GoogleFonts.outfit(textStyle: const TextStyle(fontWeight: FontWeight.w700)),)),
      centerTitle: centerTitle??true,
      backgroundColor: angryFlamingo,
      foregroundColor: Colors.white,
      toolbarHeight: 85,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),

              bottom: bottom,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(85);
}