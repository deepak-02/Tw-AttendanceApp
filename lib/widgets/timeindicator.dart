import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeRangeProgressIndicator extends StatefulWidget {
  final String startTime;
  final String endTime;
  final double? indicatorWidth;

  const TimeRangeProgressIndicator({
    super.key,
    required this.startTime,
    required this.endTime,
    this.indicatorWidth,
  });

  @override
  TimeRangeProgressIndicatorState createState() =>
      TimeRangeProgressIndicatorState();
}

class TimeRangeProgressIndicatorState
    extends State<TimeRangeProgressIndicator> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateProgress();
    // Update progress every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateProgress();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _updateProgress() {
    final now = DateTime.now();
    final startDate = DateFormat('hh:mm a').parse(widget.startTime);
    final endDate = DateFormat('hh:mm a').parse(widget.endTime);

    final totalDuration = endDate.difference(startDate).inSeconds;
    final currentDuration = now.difference(startDate).inSeconds;

    setState(() {
      _progress = currentDuration / totalDuration;
      if (_progress > 1.0) {
        _progress = 0.5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: widget.indicatorWidth ?? 30,
              right: widget.indicatorWidth ?? 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.startTime,
                style: const TextStyle(
                  color: Color(0xFF535353),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                widget.endTime,
                style: const TextStyle(
                  color: Color(0xFF535353),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8), // Adjust the spacing as needed
        Padding(
          padding: EdgeInsets.only(
              left: widget.indicatorWidth ?? 30,
              right: widget.indicatorWidth ?? 30),
          child: LinearProgressIndicator(
            value: _progress,
            valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xff8dc63f)), // Color for completed portion
            backgroundColor: Colors.white, // Color for remaining portion
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }
}
