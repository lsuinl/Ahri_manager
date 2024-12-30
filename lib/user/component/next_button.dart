import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/color.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({
    required this.onPressed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
        width: double.infinity, // 가로로 꽉 채우기
        child:
      ElevatedButton(
        style:  ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,  // 모든 모서리를 0으로 설정
          ),
          backgroundColor: MainColor,   // 배경색 설정
          foregroundColor: Colors.white, // 텍스트 색상 설정
        ),
        onPressed: onPressed,
        child: Text("다음")));
  }
}
