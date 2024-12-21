import 'package:ahri_manager/calendar/component/custom_text_field.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Text("하이");
  }
  //   return CustomTextField(
  //       label: label,
  //       isMemo: isMemo,
  //       onSaved: onSaved,
  //       initialValue: initialValue);
  // }
}
