import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ahri_manager/data/shop_information.dart';
class Shop_url extends StatefulWidget {
  final String shopname;
  const Shop_url({
    required this.shopname,
    Key? key}) : super(key: key);

  @override
  State<Shop_url> createState() => _Shop_urlState();
}

class _Shop_urlState extends State<Shop_url> {
  Map weburl={};
  WebViewController? controller;
  String shopname="";

  @override //초기에 한번만 실행
  void initState(){
    shopname=widget.shopname;
    weburl=Weburl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(shopname),
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
