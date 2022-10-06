import 'package:flutter/material.dart';
import 'package:ahri_manager/screen/shop_web.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/shop_information.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({Key? key}) : super(key: key);

  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  @override
  Widget build(BuildContext context) {
    return _birdurl();
  }
}

class _birdurl extends StatefulWidget {
  const _birdurl({Key? key}) : super(key: key);

  @override
  State<_birdurl> createState() => _birdurlState();
}

class _birdurlState extends State<_birdurl> {
  List shop_name =[];
  List<user_information> user_infotmations = []; //유저정보 리스트
  final UserHelper helper = UserHelper();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(user_infotmations.isNotEmpty) {
      if (user_infotmations.first.species == "앵무새") shop_name = birdshopname;
      if (user_infotmations.first.species == "햄스터") shop_name = hamshopname;
      if (user_infotmations.first.species == "토끼") shop_name = rabbitshopname;
      if (user_infotmations.first.species == "물고기") shop_name = pishshopname;
      if (user_infotmations.first.species == "도마뱀") shop_name = lizardshopname;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[100],
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "용품사이트 목록",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'jua',
                fontSize: 30.0,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            //배경이미지
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('asset/imgs/background3.jpg'),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //버튼 양옆 조금씩 띄우기
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //중앙배치
                crossAxisAlignment: CrossAxisAlignment.stretch, //가로로 꽉차게
                children: [
                  for (int i = 0; i < shop_name.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: ElevatedButton.icon(
                        //버튼!!!
                        icon: Image.asset('asset/imgs/${user_infotmations.first.species}.png',width: 30,),
                        label: Text(
                          shop_name[i],
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'jua',
                            fontSize: 25.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[50],
                          onPrimary: Colors.pink,
                          //애니메이션 색깔
                          shadowColor: Colors.black,
                          elevation: 5.0,
                          padding: EdgeInsets.all(15.0),
                          side: BorderSide(
                            //테두리
                            color: Colors.black38,
                            width: 1.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShopWebScreen(shopname: shop_name[i])));
                        },
                      ),
                    ),
                ],
              ),
            ),
        ),
      );
    }
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/imgs/unicorn.png',
          ),
          Text(
            "문제가 생겼습니다. 다시 시도해주세요.",
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
}
