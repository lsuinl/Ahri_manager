import 'package:flutter/material.dart';

// 일기를 캘린더 밑에 보여줍니다.
// 일기 제목

class DiaryCard extends StatelessWidget {
  final String title;

  const DiaryCard({
    required this.title,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 16.0),
              _Title(title: title), //일기 제목
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