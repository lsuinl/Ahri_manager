// 용품 판매 사이트를 볼 수 있게 해주는 스크린

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
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(weburl[shopname]));

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
              controller!.loadRequest(Uri.parse(weburl[shopname]));
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller!)
    );
  }
}
