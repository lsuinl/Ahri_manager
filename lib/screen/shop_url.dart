import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ahri_manager/screen/buy_object.dart';

class Shop_url extends StatefulWidget {
  final String shopname;
  const Shop_url({
    required this.shopname,
    Key? key}) : super(key: key);

  @override
  State<Shop_url> createState() => _Shop_urlState();
}

class _Shop_urlState extends State<Shop_url> {
  Map weburl={
    "와우버드":"https://www.wawoobird.com/",
    "버드소리":"http://birdsori.com/",
    "아가새농장":"http://www.agase.co.kr/",
    "버드모아":"http://ksh7.co.kr/index.html",
    "햄토피아":"https://hamtopia.com/",
    "햄숲":"https://www.hamsoop.com/",
    "봄해농장":"http://봄해농장.com/",
    "햄찌네":"https://www.hamzzi.net/",
    "달나라토끼농장":"http://www.dalnaratoki.com/",
    "토당마을":"https://www.todang.co.kr/",
    "청아농장":"https://cheongane.com/",
    "미니미펫":"http://minimipet.com/",
    "라라아쿠아":"https://www.raraaqua.co.kr/shop/main/index.php",
    "헬로아쿠아":"http://www.helloaqua.com/mall/index.php",
    "트로피쉬넷":"http://www.trofish.net/",
    "신세계수족관":"https://www.wpet.co.kr/",
    "줄스샵":"https://zools.co.kr/",
    "반모리":"https://www.vanmori.com/",
    "밀림펫":"http://www.milimpet.co.kr/"
  };
  WebViewController? controller;
  String shopname="";

  @override //초기에 한번만 실행
  void initState(){
    shopname=widget.shopname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.shopname),
        centerTitle: true,
        actions: [
          IconButton( //홈으로
            onPressed: (){
              if(controller == null){
                return;
              }
              controller!.loadUrl(weburl[shopname]);
            },
            icon: Icon(Icons.home,),
          ),
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller){
          this.controller = controller;
        },
        initialUrl: weburl[shopname],
        javascriptMode: JavascriptMode.unrestricted,
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