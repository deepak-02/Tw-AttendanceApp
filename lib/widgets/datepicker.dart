import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker({super.key});

  @override
  MonthYearPickerState createState() => MonthYearPickerState();
}

class MonthYearPickerState extends State<MonthYearPicker> {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  void _navigateToPreviousMonth() {
    setState(() {
      if (_month > 1) {
        _month--;
      } else {
        _month = 12;
        _year--;
      }
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      if (_month < 12) {
        _month++;
      } else {
        _month = 1;
        _year++;
      }
    });
  }

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: DateTime(_year, _month),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _month = picked.month;
        _year = picked.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 40,
              ),
              onPressed: _navigateToPreviousMonth,
              tooltip: "Previous Month",
            ),
            Tooltip(
              message: "Select Month",
              child: GestureDetector(
                onTap: () => _selectedDate(context),
                child: Row(
                  children: [
                    Text(
                      DateFormat('MMMM').format(DateTime(_year, _month)),
                      style: const TextStyle(
                        color: Color(0xFF061859),
                        fontSize: 20.12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$_year',
                      style: const TextStyle(
                        color: Color(0xFF061859),
                        fontSize: 20.12,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.chevron_right_rounded,
                size: 40,
              ),
              onPressed: _navigateToNextMonth,
              tooltip: "Next Month",
            ),
          ],
        ),
      ],
    );
  }
}
