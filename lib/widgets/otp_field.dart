import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.otpController,
    this.width,
    this.height,
    this.onChanged,
    this.autofocus,
    this.textInputAction,
  });

  final TextEditingController otpController;
  final double? width;
  final double? height;
  final void Function(String)? onChanged;
  final bool? autofocus;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 40,
      height: height ?? 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        maxLength: 1,
        autofocus: autofocus ?? false,
        onChanged: (value) {
          // Check if the length of the pasted value is 1
          if (value.length == 1) {
            // Move focus to the next field
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            // If the field becomes empty, move focus to the previous field
            FocusScope.of(context).previousFocus();
          }
          // Call the original onChanged function if provided
          onChanged?.call(value);
        },
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        controller: otpController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          counterText: '',
        ),
        textInputAction: textInputAction ?? TextInputAction.none,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
