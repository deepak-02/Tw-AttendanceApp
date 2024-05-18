import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.backgroundColor,
    required this.img,
    required this.name,
    required this.textColor,
    this.onTap,
  });

  final Color? backgroundColor;
  final String img;
  final String name;
  final Color? textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 148,
        height: 133,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SvgPicture.asset(
                img,
              ),
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
