import 'package:flutter/material.dart';
import 'package:styled_divider/styled_divider.dart';

class AttendanceWidget extends StatelessWidget {
  final String date;
  final String presentText;
  final String checkInTime;
  final String checkOutTime;
  final String totalHours;

  final double? topLeftCurve;
  final double? topRightCurve;
  final double? bottomLeftCurve;
  final double? bottomRightCurve;

  const AttendanceWidget({
    super.key,
    required this.date,
    required this.presentText,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalHours,
    this.topLeftCurve,
    this.topRightCurve,
    this.bottomLeftCurve,
    this.bottomRightCurve,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            // Adjust the border radius for one side
            topLeft: Radius.circular(topLeftCurve ?? 10.0),
            topRight: Radius.circular(topRightCurve ?? 10.0),
            bottomLeft: Radius.circular(bottomLeftCurve ?? 0),
            bottomRight: Radius.circular(bottomRightCurve ?? 0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/check-mark.png",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      presentText,
                      style: const TextStyle(
                        color: Color(0xFF00745F),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Divider(),
            const StyledDivider(
              color: Color(0xff9A9A9A),
              lineStyle: DividerLineStyle.dashed,
            ),

            const SizedBox(height: 8.0),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeColumn('Check In', checkInTime),
                  const VerticalDivider(
                    color: Color(0xff9a9a9a),
                    thickness: 1,
                  ),
                  _buildTimeColumn('Check Out', checkOutTime),
                  const VerticalDivider(
                    color: Color(0xff9a9a9a),
                    thickness: 1,
                  ),
                  _buildTimeColumn('Total Hours', totalHours),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFA6A6A6),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF535353),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    );
  }
}
