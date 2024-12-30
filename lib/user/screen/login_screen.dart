import 'package:ahri_manager/common/widgets/basic.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

//로그인
//android: google, kakao
//ios: google, kakao, apple
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Basic(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/imgs/pet-food.png',
                  width: 100,
                ),
                SizedBox(height:50),
                TextButton(onPressed: (){}, child: Text("kakao")),
                Platform.isIOS ?
                TextButton(onPressed: (){}, child: Text("apple"))
                : TextButton(onPressed: (){}, child: Text("google"))
              ],
            )));
  }
}
