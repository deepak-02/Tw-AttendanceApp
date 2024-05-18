import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShiftInfoTile extends StatelessWidget {
  final Color color;
  final String breakText;
  final String startShift;
  final String endShift;

  const ShiftInfoTile({
    super.key,
    required this.color,
    required this.breakText,
    required this.startShift,
    required this.endShift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: 334,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFF4D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      // padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/timer.svg",
              ),
              const SizedBox(width: 5),
              Text(
                breakText,
                style: const TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              )
            ],
          ),
          // const SizedBox(width: 10),
          Row(
            children: [
              const Text(
                'Start Shift',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA6A6A6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 0.17,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                startShift,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF535353),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'End Shift',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA6A6A6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 0.17,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                endShift,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF535353),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
