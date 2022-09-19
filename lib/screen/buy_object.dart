import 'package:flutter/material.dart';
import 'package:ahri_manager/screen/shop_url.dart';
//물건판매리스트(동물별로 다르게 표기)
//목록 중 하나를 선택 시, 웹사이트로 이동
class Buy_object extends StatefulWidget {
  const Buy_object({Key? key}) : super(key: key);

  @override
  State<Buy_object> createState() => _MainScreenState();
}

class _MainScreenState extends State<Buy_object> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body:SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
          '어쩔티비!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
          _List(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Web_url()));
            },
          ),
        ],
      ),
    ),
    );
  }
}



class _List extends StatelessWidget {
  final VoidCallback onPressed;

  const _List({
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
            Icons.shop,
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
