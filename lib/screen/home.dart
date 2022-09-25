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
        backgroundColor: Colors.lightGreen,

        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "놀러와 우리홈",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton( //병원 이미지
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Map_hospital()));
                    },
                    icon: Image.asset('imgs/hospital.png'),
                    iconSize: 100,
                  ),

                Text(
                      '병원 찾기',
                      style: TextStyle(
                        fontFamily: 'jua',
                        fontSize: 25.0,
                      ),
                    ),
              ],
            ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: IconButton( //물품 이미지
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Buy_object()));
                    },
                    icon: Image.asset('imgs/pet-food.png'),
                    iconSize: 100,
                  ),
                ),


                Text(
                  "물품구매",
                  style: TextStyle(
                    fontFamily: 'jua',
                    fontSize: 25.0,
                  ),
                ),

            IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Buy_object()));
                    },
                    icon: Image.asset('imgs/schedule.png'),
                    iconSize: 100,
                    //padding,
                  ),


                Text(
                  "기록장",
                  style: TextStyle(
                    fontFamily: 'jua',
                    fontSize: 25.0,
                  ),
                ),


            //설정으로
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                child: Text(
                  "설정",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Buy_object()));
                },
              ),
            ),
          ],
        ),

      ),
    );
  }
}
