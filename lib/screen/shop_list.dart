import 'package:flutter/material.dart';
import 'package:ahri_manager/screen/shop_web.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/shop_information.dart';

//물건판매리스트(동물별로 다르게 표기)
//목록 중 하나를 선택 시, 웹사이트로 이동
class BuyObjectScreen extends StatefulWidget {
  const BuyObjectScreen({Key? key}) : super(key: key);

  @override
  State<BuyObjectScreen> createState() => _BuyObjectScreenState();
}

class _BuyObjectScreenState extends State<BuyObjectScreen> {
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
    if(user_infotmations.isNotEmpty) {
      if (user_infotmations.first.species == "앵무새") shop_name = birdshopname;
      if (user_infotmations.first.species == "햄스터") shop_name = hamshopname;
      if (user_infotmations.first.species == "토끼") shop_name = rabbitshopname;
      if (user_infotmations.first.species == "물고기") shop_name = pishshopname;
      if (user_infotmations.first.species == "도마뱀") shop_name = lizardshopname;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "자본을 뿌려보아요",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'jua',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), //버튼 양옆 조금씩 띄우기
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //왜 중간으로 안 가는겨
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < shop_name.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton.icon(
                    //버튼!!!
                    icon: Icon(Icons.shopping_bag_outlined,
                        size: 20, color: Colors.black),
                    label: Text(
                      shop_name[i],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'jua',
                        fontSize: 25.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      onPrimary: Colors.lightGreen,
                      //애니메이션 색깔
                      shadowColor: Colors.black,
                      elevation: 5.0,
                      padding: EdgeInsets.all(15.0),
                      side: BorderSide(
                        //테두리
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShopUrlScreen(shopname: shop_name[i])));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }
}
