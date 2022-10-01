import 'package:ahri_manager/screen/input_animal_information.dart';
import 'package:flutter/material.dart';
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/user_information.dart';


//내 동물 정보 조회, 배경테마설정
class MyAnimalScreen extends StatefulWidget {
  const MyAnimalScreen({Key? key}) : super(key: key);
  @override
  State<MyAnimalScreen> createState() => _MyAnimalScreenState();
}

class _MyAnimalScreenState extends State<MyAnimalScreen> {
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
    if (user_infotmations.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "${user_infotmations.first.name}의 정보",
              style: TextStyle(
                fontFamily: 'jua',
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ), //동물 이름 띄우는 걸로 수정했어요
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //사이 균등하게 배분
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "동물 정보를 표기합니다.",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'jua',
                  color: Colors.green,
                ),
              ),
              Text(
                '이름: ${user_infotmations.first.name}',
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              Text(
                '몸무게: ${user_infotmations.first.weight}kg',
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              Text(
                '종: ${user_infotmations.first.species}',
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              Text(
                '성별: ${user_infotmations.first.gender}',
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              Text(
                '중성화: ${user_infotmations.first.neu}',
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              Text(
                "생일: ${user_infotmations.first.selectedyear}년 ${user_infotmations.first.selectedmonth}월 ${user_infotmations.first.selectedday}일",
                style: TextStyle(
                  fontFamily: 'jua',
                  fontSize: 25.0,
                ),
              ),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: const Text(
                    '저장 완료!',
                    style: TextStyle(
                      fontFamily: 'jua',
                      fontSize: 23.0,
                    ),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StartScreen()));
                },
              ),
            ],
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
            "문제가 생겼습다. 다시 시도해주세요.",
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
  }
  void updateScreen(){
    user_infotmations=helper.getuserinformation();
    setState(() {});
  }
}
