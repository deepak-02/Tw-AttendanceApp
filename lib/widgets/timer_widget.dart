import 'dart:async';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/blocs/login_bloc/login_bloc.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.phone});

  final String phone;
  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> with CodeAutoFill {
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  void _resendCode() async {
    //resend function
    String signature = await SmsAutoFill().getAppSignature;
    callBloc(signature);
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  void callBloc(String signature) {
    // this is to avoid the warning :  Don't use 'BuildContext's across async gaps.
    BlocProvider.of<LoginBloc>(context)
        .add(VerifyOtpBtnClickEvent(signature: signature, phone: widget.phone, resend: true));
  }

  @override
  void initState() {
    super.initState();

    listenForCode();

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is OtpErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0x3F000000),
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            enableResend = true;
          });
        }
      },
      child: Container(
        // width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Haven't received the OTP,",
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF6F6F6F),
              ),
            ),
            TextButton(
                onPressed: enableResend ? _resendCode : null,
                child: const Text(
                  "Resend",
                  style: TextStyle(
                      fontSize: 12.0,
                      //color: Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                )),
            Text(
              enableResend ? "" : "in $secondsRemaining",
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF6F6F6F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void codeUpdated() {
    setState(() {});
  }
}
