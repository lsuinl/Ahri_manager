import 'package:flutter/material.dart';

class Web_url extends StatelessWidget {
  const Web_url({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          Text(
          'Hello ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
          _Backbutton(onPressed: (){
            Navigator.pop(context);
          },
          ),
      ],
      ),
    );
  }
}


class _Backbutton extends StatelessWidget {
  final VoidCallback onPressed;

  const _Backbutton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: 60,
          onPressed: onPressed,
          icon: Icon(
            Icons.backspace,
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
