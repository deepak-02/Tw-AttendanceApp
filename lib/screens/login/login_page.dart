import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as nav;
import 'package:sms_autofill/sms_autofill.dart';
import 'package:untitled/screens/home/home.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryCode = 'IN';

  // String ? phoneNumber;
  TextEditingController phoneController = TextEditingController();

  String? errorMsg;

  // final _phoneNumberSuggestion_3Plugin = PhoneNumberSuggestion_3();

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  @override
  void dispose() {
    phoneController.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void getPhone() {
    Future.delayed(const Duration(seconds: 1), () async {
      // phoneNumber = await SmsAutoFill().hint;
      phoneController.text = await SmsAutoFill().hint ?? '';

      print(phoneController.text);
      // if (phoneController.text != '') {
      //   nav.Get.to(
      //     OtpPage(phone: phoneController.text,),
      //     // const Home(),
      //     transition: nav.Transition.downToUp,
      //     duration: const Duration(milliseconds: 800),
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
            } else if (state is OtpErrorState) {
              setState(() {
                errorMsg = state.error;
              });
            } else if (state is OtpSuccessState) {
              nav.Get.to(
                OtpPage(
                  phone: phoneController.text,
                ),
                transition: nav.Transition.downToUp,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          "Login with us",
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            errorMsg = null;
                          });
                        },
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        onChanged: (value) {
                          if (errorMsg != null) {
                            setState(() {
                              errorMsg = null;
                            });
                          }
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    if (state is OtpLoadingState)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff21206a),
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
                            onPressed: () async {
                              print("aaaaaa");
                              String signature = await SmsAutoFill().getAppSignature;
                              loginBloc.add(PhoneChangeEvent(
                                  phone: phoneController.text));
                              loginBloc.add(VerifyOtpBtnClickEvent(signature: signature));
                            },
                            child: const Text(
                              'Continue',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                ElevatedButton(onPressed: (){ nav.Get.to(
                  Home(),
                  transition: nav.Transition.downToUp,
                  duration: const Duration(milliseconds: 800),
                );}, child: Text("Login without phone/otp")),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }

// Future<void> validate() async {
//   if (phoneController.text.isEmpty) {
//     setState(() {
//       errorMsg = "Empty fields!";
//     });
//     // Future.delayed(const Duration(seconds: 2), () {
//     //   setState(() {
//     //     errorMsg = null;
//     //   });
//     // });
//
//   } else {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("phone", phoneController.text);
//
//     nav.Get.to(
//       OtpPage(phone: phoneController.text,),
//       // const Home(),
//       transition: nav.Transition.downToUp,
//       duration: const Duration(milliseconds: 800),
//     );
//   }
// }
}
