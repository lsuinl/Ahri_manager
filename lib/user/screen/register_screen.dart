import 'package:ahri_manager/common/widgets/basic.dart';
import 'package:ahri_manager/user/component/next_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final String? title;
  final Widget content;

  const RegisterScreen({required this.content, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Basic(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        BackButton(),
        Center(
          child: title == null ?Container(): Text(title!), //hmm
        ),
        ]),
        content,
        NextButton(),
      ],
    ));
  }
}
