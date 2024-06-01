import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as nav;
import 'package:sms_autofill/sms_autofill.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import '../../widgets/background.dart';
import '../../widgets/timer_widget.dart';
import '../home/home.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phone});

  final String phone;

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();

  String? appSignature;
  String? otpCode;
  String? errorMsg;


  @override
  void codeUpdated() {
    if (kDebugMode) {
      print("Code updated...");
    }
    setState(() {
      otpCode = '';
      FocusScope.of(context).requestFocus(FocusNode());
      otpCode = code;
      if (otpCode != null) {
        otpController.text = otpCode!;
        if (kDebugMode) {
          print(otpController.text);
          print("updated...");
        }

      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  dispose() {
    otpController.dispose();
    otpCode = '';
    SmsAutoFill().unregisterListener();
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (kDebugMode) {
              print("State: $state");
            }

            if (state is EmptyFieldsState) {
              setState(() {
                errorMsg = "Empty fields!";
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  errorMsg = null;
                });
              });
            } else if (state is LoginErrorState) {
              setState(() {
                errorMsg = state.error;
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  errorMsg = null;
                });
              });
            } else if (state is LoginSuccessState) {
              nav.Get.offAll(
                const Home(),
                transition: nav.Transition.circularReveal,
                duration: const Duration(milliseconds: 800),
              );
            } else if (state is OtpResendState) {
              listenForCode();
              setState(() { FocusScope.of(context).requestFocus(FocusNode());
              otpController.clear();
              otpCode = '';
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                const Background(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 30),
                          child: SizedBox(
                            width: 40,
                            child: SvgPicture.asset(
                              "assets/icons/splash_logo1.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Please enter the OTP sent to",
                              style: TextStyle(
                                color: Color(0xFF6F6F6F),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              widget.phone,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),

                            // OTP Fields
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 20, bottom: 10),
                              child: PinFieldAutoFill(
                                codeLength: 6,
                                cursor: Cursor.disabled(),
                                controller: otpController,
                                decoration: BoxLooseDecoration(
                                  gapSpace: 5,
                                  strokeColorBuilder: FixedColorBuilder(
                                      Colors.black.withOpacity(0.3)),
                                ),
                                currentCode: otpCode,
                                onCodeSubmitted: (code) {},
                                onCodeChanged: (code) {
                                  if (code!.length == 6) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                },
                              ),
                            ),

                            TimerWidget(
                              phone: widget.phone,
                            ),

                            // Login Button
                            if (state is LoginLoadingState)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: 400,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff8dc63f),
                                    // color: const Color(0xff21206a),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 3,
                                      backgroundColor: const Color(0xff8dc63f),
                                      // backgroundColor: const Color(0xff21206a),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8.0)),
                                      minimumSize: const Size(100, 40),
                                    ),
                                    onPressed: () {
                                      otpCode = otpController.text;
                                      loginBloc.add(OtpChangeEvent(
                                          otp: otpController.text));
                                      loginBloc.add(LoginBtnClickEvent());
                                      otpCode = '';
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),

                            if (errorMsg != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "$errorMsg",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
