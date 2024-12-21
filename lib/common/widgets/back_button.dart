import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
        onPressed: (){}, 
        icon: Icon(Icons.arrow_back_ios_new)));
  }
}
