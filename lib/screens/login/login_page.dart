import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as nav;
import 'package:sms_autofill/sms_autofill.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import '../../widgets/background.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  String? errorMsg;

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
      phoneController.text = await SmsAutoFill().hint ?? '';

      if (kDebugMode) {
        print(phoneController.text);
      }
      setState(() {});
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
          bloc: loginBloc,
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
                FocusScope.of(context).unfocus();
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
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            const Text(
                              'Please enter your mobile number to login via OTP',
                              style: TextStyle(
                                color: Color(0xFF6F6F6F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              onTap: () {
                                setState(() {
                                  errorMsg = null;
                                });
                              },
                              controller: phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
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
                            if (state is OtpLoadingState)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
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
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 3,
                                      backgroundColor: const Color(0xff21206a),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      minimumSize: const Size(100, 40),
                                    ),
                                    onPressed: phoneController.text.isEmpty
                                        ? null
                                        : click,
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: phoneController.text.isEmpty
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            if (errorMsg != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
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
                    // ElevatedButton(onPressed: (){ nav.Get.to(
                    //   Home(),
                    //   transition: nav.Transition.downToUp,
                    //   duration: const Duration(milliseconds: 800),
                    // );}, child: Text("Login without phone/otp")),
                    // const Spacer(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void click() async {
    String signature = await SmsAutoFill().getAppSignature;
    navigate(signature);
  }

  void navigate(String signature) {
    BlocProvider.of<LoginBloc>(context)
        .add(PhoneChangeEvent(phone: phoneController.text));
    BlocProvider.of<LoginBloc>(context).add(VerifyOtpBtnClickEvent(
        signature: signature, phone: phoneController.text, resend: false));
  }
}
