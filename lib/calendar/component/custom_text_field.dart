import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 사용자에게서 데이터를 입력받는 클래스

class CustomTextField extends StatelessWidget {
  final String initialValue;
  final String label;
  final bool isMemo;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.label,
    //required this.isTime,
    required this.isMemo,
    required this.onSaved,
    required this.initialValue,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //label을 왼쪽으로 배치
      children: [
        Text(
          label, //작은 글씨
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.w600,
          ),
        ),
        renderTextField(),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved, //상위 폼에서 save라는 함수를 불렀을 때 이 함수가 모두 불린다.

      //null이 return 되는 에러가 없다.
      //에러가 있으면 에러를 String 값으로 리턴한다.
      validator: (String? val){
        if (val == null || val.isEmpty){ //텍스트가 입력되지 않았다!면
          return '값을 입력해주세요.'; //값을 입력해달라고 띄워보리기
        }

        return null;
      },
      cursorColor: Colors.grey, //커서 색 설정 (텍스트 입력하면 바로 옆에 깜빡이는 세로줄)
      maxLines: isMemo ? 4 : 1, //최대 쓸 수 있는 줄 수 (null값은 줄 제한X)
      initialValue: initialValue,
      //expands: isMemo, //메모 늘리기
      decoration: InputDecoration(
        border: InputBorder.none, //입력칸 밑줄 없애기
        filled: true, //밑줄대신 네모칸 보이기
        fillColor: Colors.pink[50], //네모칸 색 설정 (회색으로 해둠)
      ),
    );
  }
}