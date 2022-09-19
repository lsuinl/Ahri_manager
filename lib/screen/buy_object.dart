import 'package:flutter/material.dart';
//물품구매 사이트 모음
//웹사이트 불러오기. +내정보(동물종류)에 따라 표기되는 사이트 다름
class buy_object extends StatefulWidget {
  const buy_object({Key? key}) : super(key: key);

  @override
  State<buy_object> createState() => wow();
}

class wow extends State<buy_object> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.indigoAccent,
      body: Center(
        child: Text(
          'djWjf World',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
