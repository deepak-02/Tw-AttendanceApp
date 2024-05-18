import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {

  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;


  void _resendCode() {
    //resend function
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }


  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });

  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
      MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Didn't get the OTP? ",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          TextButton(
              onPressed: enableResend
                  ? _resendCode
                  : null,
              child: const Text(
                "Resend",
                style: TextStyle(
                    fontSize: 16.0,
                    //color: Color(0xffffffff),
                    fontWeight:
                    FontWeight.bold),
              )),
          Text(enableResend?
          "":"($secondsRemaining)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
