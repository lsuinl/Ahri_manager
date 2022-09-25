import 'package:flutter/material.dart';
import 'package:ahri_manager/screen/shop_url.dart';

//물건판매리스트(동물별로 다르게 표기)
//목록 중 하나를 선택 시, 웹사이트로 이동
class Buy_object extends StatefulWidget {
  const Buy_object({Key? key}) : super(key: key);

  @override
  State<Buy_object> createState() => _Buy_objectState();
}

class _Buy_objectState extends State<Buy_object> {
  final String animalname = "앵무새";

  @override
  Widget build(BuildContext context) {
    return _birdurl(animalname: animalname);
  }
}

class _birdurl extends StatefulWidget {
  final String animalname;

  const _birdurl({required this.animalname, Key? key}) : super(key: key);

  @override
  State<_birdurl> createState() => _birdurlState();
}

class _birdurlState extends State<_birdurl> {
  List birdshopname = ["와우버드", "버드소리", "아가새농장", "버드모아"];
  List hamshopname = ["햄토피아", "햄숲", "봄해농장", "햄찌네"];
  List rabbitshopname = ["달나라토끼농장", "토당마을", "청아농장", "미니미펫"];
  List pishshopname = ["라라아쿠아", "헬로아쿠아", "트로피쉬넷", "신세계수족관"];
  List lizardshopname = ["줄스샵", "반모리", "밀림펫"];

  @override
  Widget build(BuildContext context) {
    List animalshop = [];
    if (widget.animalname == "앵무새") animalshop = birdshopname;
    if (widget.animalname == "햄스터") animalshop = hamshopname;
    if (widget.animalname == "토끼") animalshop = rabbitshopname;
    if (widget.animalname == "물고기") animalshop = pishshopname;
    if (widget.animalname == "도마뱀") animalshop = lizardshopname;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < animalshop.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ElevatedButton.icon(
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
                  style: ElevatedButton.styleFrom(primary: Colors.white),
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
    );
  }
}
