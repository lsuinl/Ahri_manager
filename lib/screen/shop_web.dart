import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ahri_manager/data/shop_information.dart';

class ShopWebScreen extends StatefulWidget {
  final String shopname;
  const ShopWebScreen({required this.shopname, Key? key}) : super(key: key);

  @override
  State<ShopWebScreen> createState() => _ShopWebScreenState();
}

class _ShopWebScreenState extends State<ShopWebScreen> {
  Map weburl = {};
  WebViewController? controller;
  String shopname = "";

  @override //초기에 한번만 실행
  void initState() {
    shopname = widget.shopname;
    weburl = Weburl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //앱바
        backgroundColor: Colors.red[100],
        title: Text(
          shopname,
          style: TextStyle(
            fontFamily: 'jua',
            fontSize: 30.0,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(1.0, 1.0),
              )
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (controller == null) {
                return;
              }
              controller!.loadUrl(weburl[shopname]);
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebView( //웹페이지 표기 위젯
        onWebViewCreated: (WebViewController controller){this.controller = controller;},
        initialUrl: weburl[shopname],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
