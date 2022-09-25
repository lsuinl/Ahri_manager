import 'package:ahri_manager/screen/buy_object.dart';
import 'package:ahri_manager/screen/map_hospital.dart';
import 'package:ahri_manager/screen/my.dart';
import 'package:flutter/material.dart';
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/user_data.dart';


//메인화면(탭 선택 화면)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List<user_information> user_infotmations=[]; //유저정보 리스트
  final UserHelper helper=UserHelper();
  @override
  void initState(){
    helper.init().then((value){
     updateScreen();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user_infotmations.first.species}${user_infotmations.first.name}의 집"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Map_hospital()));
              },
              icon: Image.asset('/Users/kimsu-in/Desktop/icecream/flutter-sw/imgs/hospital.png'),
            iconSize: 100,),
            Text("병원찾기"),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Buy_object()));
              },
              icon: Image.asset('/Users/kimsu-in/Desktop/icecream/flutter-sw/imgs/pet-food.png'),
              iconSize: 100,),
            Text("물품구매"),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Buy_object()));
              },
              icon: Image.asset('/Users/kimsu-in/Desktop/icecream/flutter-sw/imgs/schedule.png'),
            iconSize: 100,
              //padding,
            ),
            Text("기록장"),
            //설정으로
            ElevatedButton(
              child: Text(
                "설정",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            My()));
              },
            ),
          ],
        ),
      ),
    );
  }



  //데이터 가져오기
  void updateScreen(){
    user_infotmations= helper.getuserinformation();
    setState(() {});
  }
  }

