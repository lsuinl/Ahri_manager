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
        title: Text("안녕"),
        centerTitle: true,
        actions: [
          IconButton( //홈으로
            onPressed: (){
              if(controller == null){
                return;
              }
              controller!.loadUrl('https://velog.io/@su96in43');
            },
            icon: Icon(Icons.home,),
          ),
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller){
          this.controller = controller;
        },
        initialUrl: 'https://velog.io/@su96in43',
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