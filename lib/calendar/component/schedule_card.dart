import 'package:flutter/material.dart';

// 캘린더 밑에 일정 리스트 관리
// 일정 제목 | 카테고리 색상

class ScheduleCard extends StatelessWidget {
  final String title; //일정 제목
  final Color color; //일정 카테고리 색깔

  const ScheduleCard({
    required this.title,
    required this.color,
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
        child: IntrinsicHeight( //Row가 최대한으로 차지하고 있는 사이즈만큼 높이 지정.
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 16.0),
              _Title(title: title), //일정 제목
              SizedBox(width: 16.0),
              _Category(color: color), //일정 카테고리 색깔
            ],
          ),
        ),
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
    return Expanded(child: Text(title));
  }
}

class _Category extends StatelessWidget { //카테고리 색상
  final Color color;
  const _Category({
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}