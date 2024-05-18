import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    super.key,
    required this.toolTip,
    required this.onTap,
    required this.svgImage,
    required this.text,
    this.isSelected,
  });

  final String? toolTip;
  final void Function()? onTap;
  final String svgImage;
  final String text;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        isSelected == true
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 64,
                  height: 3,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF8DC63F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: 64,
                  height: 3,
                ),
              ),
        Tooltip(
          message: toolTip ?? '',
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  svgImage,
                  width: 30,
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      // height: 0.13,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
