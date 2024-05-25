import 'package:flutter/material.dart';

import '../../../../widgets/attendcard.dart';
import '../../../../widgets/datepicker.dart';

class AttendanceReport extends StatelessWidget {
  const AttendanceReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededee),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        backgroundColor: const Color(0xff21206a),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Attendance Report',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: 32,
                      child: Image.asset(
                        "assets/icons/splash_logo.png",
                        fit: BoxFit.fitWidth,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const MonthYearPicker(),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const AttendanceWidget(
                    date: 'Monday 1 April 2024',
                    presentText: 'Present',
                    checkInTime: '09:00 AM',
                    checkOutTime: '05:00 PM',
                    totalHours: '8 hours',
                    bottomLeftCurve: 10,
                    bottomRightCurve: 10,
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
