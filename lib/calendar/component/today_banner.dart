import 'package:ahri_manager/data/database/drift_database.dart';
import 'package:ahri_manager/screen/diary.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../model/schedule_with_color.dart';

/*
달력과 투두리스트 사이에 있는 바 관리 코드 (날짜|할 일 개수)
 */

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
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryScreen()),);
                },
                icon: Icon(Icons.ac_unit))
          ],
        ),
      ),
    );
  }
}
