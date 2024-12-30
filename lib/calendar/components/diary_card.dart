// 일기를 캘린더 밑에 보여줍니다.
// 오늘 날짜 | 일기 제목 | 일기 내용

import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;

  const DiaryCard({
    required this.title,
    required this.content,
    required this.date,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey, //스케줄 테두리 색
        ),
        borderRadius: BorderRadius.circular(8.0), //테두리 각진 거 둥글게!
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 16.0),
              _Date(date: date),
              SizedBox(width: 16.0),
              _Title(title: title),
              SizedBox(width: 16.0,),
              _Content(content: content,),
            ],
          ),
        ),
      ),
    );
  }
}

class _Date extends StatelessWidget { //제목
  final DateTime date;

  const _Date({ //데이터 불러오기
    required this.date,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${date.year}.${date.month}.${date.day}",
      style: TextStyle(
        fontFamily: 'jua',
        fontSize: 15.0,
        color: Colors.pink[300],
      ),
    );
  }
}


class _Title extends StatelessWidget { //제목
  final String title;

  const _Title({ //데이터 불러오기
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
        fontFamily: 'jua',
        fontSize: 30.0,
        color: Colors.pink,
        ),
    );
  }
}

class _Content extends StatelessWidget { //제목
  final String content;

  const _Content({ //데이터 불러오기
    required this.content,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content,
      style: TextStyle(
        fontFamily: 'jua',
        fontSize: 15.0,
        color: Colors.black,
      ),
    ));
  }
}