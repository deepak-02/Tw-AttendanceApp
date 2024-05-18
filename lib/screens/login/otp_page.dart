import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../widgets/otp_field.dart';
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
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  // TextEditingController otpController5 = TextEditingController();
  // TextEditingController otpController6 = TextEditingController();

  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();


  String? appSignature;
  String? otpCode;


  // listenForOtp () async {
  //   await SmsAutoFill().listenForCode();
  // }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
            if (otpCode!=null) {
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
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    SmsAutoFill().unregisterListener();
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
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
                    // Image.asset(
                    //   "assets/icons/splash_logo.png",
                    //   fit: BoxFit.fitWidth,
                    // )
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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

                // // OTP Fields
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0,bottom: 20),
                //   child:
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //
                //       //OTP field 1
                //       OtpField(
                //           otpController: otpController1,
                //         onChanged: (value) {
                //           // if (value.length == 1) {
                //           //   FocusScope.of(context)
                //           //       .nextFocus();
                //           // }
                //           print(value);
                //         },
                //         // autofocus: true,
                //         textInputAction: TextInputAction.next,
                //       ),
                //
                //       //OTP field 2
                //       OtpField(
                //         otpController: otpController2,
                //         onChanged: (value) {
                //           print(value);
                //           // if (value.length == 1) {
                //           //   FocusScope.of(context)
                //           //       .nextFocus();
                //           // }
                //           // if (value.isEmpty) {
                //           //   FocusScope.of(context).previousFocus();
                //           // }
                //         },
                //         textInputAction: TextInputAction.next,
                //
                //       ),
                //
                //       //OTP field 3
                //       OtpField(
                //         otpController: otpController3,
                //         onChanged: (value) {
                //           print(value);
                //           // if (value.length == 1) {
                //           //   FocusScope.of(context)
                //           //       .nextFocus();
                //           // }
                //           // if (value.isEmpty) {
                //           //   FocusScope.of(context).previousFocus();
                //           // }
                //         },
                //         textInputAction: TextInputAction.next,
                //
                //       ),
                //
                //       //OTP field 4
                //       OtpField(
                //         otpController: otpController4,
                //         onChanged: (value) {
                //           print(value);
                //           // if (value.length == 1) {
                //           //   FocusScope.of(context)
                //           //       .nextFocus();
                //           // }
                //           // if (value.isEmpty) {
                //           //   FocusScope.of(context).previousFocus();
                //           // }
                //         },
                //         textInputAction: TextInputAction.done,
                //
                //       ),
                //
                //
                //     ],
                //   ),
                //
                //
                // ),




                //
                // Padding(
                //   padding: const EdgeInsets.only(left: 50,right: 50,top: 8.0,bottom: 8.0),
                //   child: PinCodeTextField(
                //     length: 4,
                //     obscureText: false,
                //     animationType: AnimationType.fade,
                //     pinTheme: PinTheme(
                //       shape: PinCodeFieldShape.box,
                //       borderRadius: BorderRadius.circular(5),
                //       fieldHeight: 50,
                //       fieldWidth: 40,
                //       activeFillColor: Colors.white,
                //       // activeColor: Colors.blue,
                //       inactiveColor: Colors.grey
                //     ),
                //     animationDuration: Duration(milliseconds: 300),
                //     // backgroundColor: Colors.blue.shade50,
                //     // enableActiveFill: true,
                //     errorAnimationController: errorController,
                //     controller: otpController1,
                //     // showCursor: true,
                //     // cursorColor: Colors.black,
                //     onCompleted: (v) {
                //       print("Completed : $v");
                //     },
                //     onChanged: (value) {
                //       print(value);
                //       // setState(() {
                //       //   // currentText = value;
                //       // });
                //     },
                //     beforeTextPaste: (text) {
                //       print("Allowing to paste $text");
                //       //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //       //but you can show anything you want here, like your pop up saying wrong paste format or etc
                //       return false;
                //     },
                //     // dialogConfig: DialogConfig(
                //     //   dialogContent: ' ',
                //     //   dialogTitle: '1234',
                //     //
                //     // ),
                //     appContext: context,
                //     keyboardType:
                //     TextInputType.number,
                //     inputFormatters: <
                //         TextInputFormatter>[
                //       FilteringTextInputFormatter
                //           .digitsOnly
                //     ],
                //   ),
                // ),


                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 8.0,bottom: 20.0),
                  child: PinFieldAutoFill(
                    codeLength: 4,
                    cursor: Cursor.disabled(),
                    controller: otpController1,
                    decoration: BoxLooseDecoration(
                      strokeColorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),

                    ),

                    // UnderlineDecoration(
                    //   textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                    //   colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    // ),
                    currentCode: otpCode,
                    onCodeSubmitted: (code) { },
                    onCodeChanged: (code) {
                      if (code!.length == 4) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                  ),
                ),





                // Login Button
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
                        if (kDebugMode) {
                          // print(phoneController.text);
                          // print(phoneNumber);
                        }
                        Get.offAll(
                          const Home(),
                          transition: Transition.circularReveal,
                          duration: const Duration(milliseconds: 800),
                        );
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),


                const TimerWidget(),




                // ElevatedButton(
                //   child: const Text('Set code to 123456'),
                //   onPressed: () async {
                //     setState(() {
                //       otpCode = '1234';
                //
                //       if (otpCode!=null) {
                //         otpController1.text = otpCode!;
                //         // otpController1.text = otpCode![0];
                //         // otpController2.text = otpCode![1];
                //         // otpController3.text = otpCode![2];
                //         // otpController4.text = otpCode![3];
                //       }
                //
                //
                //     });
                //   },
                // ),


              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


