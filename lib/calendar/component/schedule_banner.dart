//달력과 투두리스트 사이에 있는 바 관리 코드 (날짜 | 일기 버튼)

import 'package:ahri_manager/screen/diary.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  //final int scheduleCount; //할 일 개수

  const TodayBanner({
    required this.selectedDay,
    //required this.scheduleCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle( //투데이배너 글씨 style
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );


    return Container(
      color: Colors.pink[100], //배너 배경 색깔
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '''${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일
     Schedule''',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryScreen()),);
                },
              
              style: ElevatedButton.styleFrom(primary: Colors.pink[200]),
              child: Text("일기"),
            )

            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryScreen()),);
            //     },
            //     icon: Icon(Icons.pets,
            //     color: Colors.white,))
          ],
        ),
      ),
    );
  }
}
