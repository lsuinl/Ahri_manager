import 'package:flutter/material.dart';
import 'package:ahri_manager/screen/shop_url.dart';
import 'package:ahri_manager/data/user_data.dart';
import 'package:ahri_manager/plus/user_helper.dart';

//물건판매리스트(동물별로 다르게 표기)
//목록 중 하나를 선택 시, 웹사이트로 이동
class Buy_object extends StatefulWidget {
  const Buy_object({Key? key}) : super(key: key);

  @override
  State<Buy_object> createState() => _Buy_objectState();
}

class _Buy_objectState extends State<Buy_object> {
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
  List birdshopname = ["와우버드", "버드소리", "아가새농장", "버드모아"];
  List hamshopname = ["햄토피아", "햄숲", "봄해농장", "햄찌네"];
  List rabbitshopname = ["달나라토끼농장", "토당마을", "청아농장", "미니미펫"];
  List pishshopname = ["라라아쿠아", "헬로아쿠아", "트로피쉬넷", "신세계수족관"];
  List lizardshopname = ["줄스샵", "반모리", "밀림펫"];
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
    List animalshop = [];
    if (user_infotmations.first.species == "앵무새") animalshop = birdshopname;
    if (user_infotmations.first.species == "햄스터") animalshop = hamshopname;
    if (user_infotmations.first.species == "토끼") animalshop = rabbitshopname;
    if (user_infotmations.first.species == "물고기") animalshop = pishshopname;
    if (user_infotmations.first.species == "도마뱀") animalshop = lizardshopname;
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
        centerTitle: true, //가운데 정렬
        elevation: 0.0,
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
              for (int i = 0; i < animalshop.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton.icon(
                    //버튼!!!
                    icon: Icon(Icons.shopping_bag_outlined,
                        size: 20, color: Colors.black),
                    label: Text(
                      animalshop[i],
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
                                  Shop_url(shopname: animalshop[i])));
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
