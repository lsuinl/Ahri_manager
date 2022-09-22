import 'package:ahri_manager/screen/buy_object.dart';
import 'package:ahri_manager/screen/d_day.dart';
import 'package:ahri_manager/screen/map_hospital.dart';
import 'package:flutter/material.dart';

//메인화면(탭 선택 화면)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("놀러와 우리홈"),
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
                            D_day()));
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
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Buy_object()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

