import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as nav;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import '../../widgets/timer_widget.dart';
import '../home/home.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phone});

  final String phone;

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> with CodeAutoFill {
  TextEditingController otpController1 = TextEditingController();

  // TextEditingController otpController2 = TextEditingController();
  // TextEditingController otpController3 = TextEditingController();
  // TextEditingController otpController4 = TextEditingController();
  // TextEditingController otpController5 = TextEditingController();
  // TextEditingController otpController6 = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  String? appSignature;
  String? otpCode;
  String? errorMsg;

  // listenForOtp () async {
  //   await SmsAutoFill().listenForCode();
  // }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
      if (otpCode != null) {
        otpController1.text = otpCode!;
        // otpController1.text = otpCode![0];
        // otpController2.text = otpCode![1];
        // otpController3.text = otpCode![2];
        // otpController4.text = otpCode![3];
      }
    });

    // after getting the otp to auto fetch , call the verify otp and navigate to next page on success
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
    otpController1.dispose();
    // otpController2.dispose();
    // otpController3.dispose();
    // otpController4.dispose();
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
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xff21206a),
                    child: Center(
                      child: SizedBox(
                        width: 80,
                        child: SvgPicture.asset(
                          "assets/icons/splash_logo1.svg",
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Text(
                        "Techwyse: Mark your seats ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Divider(
                          indent: 20.0,
                          endIndent: 10.0,
                          thickness: 1.5,
                        )),
                        Text(
                          "Enter OTP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D1E1F)),
                        ),
                        Expanded(
                            child: Divider(
                          indent: 20.0,
                          endIndent: 10.0,
                          thickness: 1.5,
                        )),
                      ]),
                    ),

                    // OTP Fields
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8.0, bottom: 20.0),
                      child: PinFieldAutoFill(
                        codeLength: 6,
                        cursor: Cursor.disabled(),
                        controller: otpController1,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder:
                              FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        ),
                        currentCode: otpCode,
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          if (code!.length == 6) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
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
                            color: const Color(0xff21206a),
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
                              backgroundColor: const Color(0xff21206a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              minimumSize: const Size(100, 40),
                            ),
                            onPressed: () {
                              loginBloc.add(
                                  OtpChangeEvent(otp: otpController1.text));
                              loginBloc.add(LoginBtnClickEvent());
                            },
                            child: const Text(
                              'LOGIN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),

                    const TimerWidget(),

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
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}
