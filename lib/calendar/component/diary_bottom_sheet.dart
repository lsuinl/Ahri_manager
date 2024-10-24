//하단에서 창이 올라와 다이어리 데이터를 저장할 수 있는 코드

import 'package:ahri_manager/calendar/component/custom_text_field.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/database/drift_database.dart';

class DiaryBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? diaryId;

  const DiaryBottomSheet({
    required this.selectedDate,
    this.diaryId,
    Key? key}) : super(key: key);

  @override
  State<DiaryBottomSheet> createState() => _DiaryBottomSheetState();
}

class _DiaryBottomSheetState extends State<DiaryBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottonInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .requestFocus(FocusNode()); //현재 포커스 되어 있는 곳에서 포커스를 없앨 수 있다.
          }, //키보드가 실행된 상태에서 bottom_sheet 아무 곳이나 누르면 키보드가 내려감
          child: FutureBuilder<DiaryData>(
            future: widget.diaryId == null
                ? null
                : GetIt.I<LocalDatabase>().getDiaryById(widget.diaryId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('일기를 불러올 수 없습니다.'),
                );
              }

              //로딩중일 때
              if (snapshot.connectionState != ConnectionState.none &&
                  !snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && title == null) {
                title = snapshot.data!.title;
                content = snapshot.data!.content;
              }

              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2 + bottonInset,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottonInset),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0),
                            _Title(
                              onSavedTitle: (String? val) {
                                title = val;
                              },
                              initialValue: title ?? '',
                            ), //일정 내용 입력
                            SizedBox(height: 16.0),
                            _Content(
                              onSavedContent: (String? val) {
                                content = val;
                              },
                              initialValue: content ?? '',
                            ), //추가적 메모 입력
                            SizedBox(height: 8.0),
                            _SaveButton(
                              onPressed: onSavePressed,
                            ), //저장 버튼
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }

  Future<void> onSavePressed() async {
    if (formKey.currentState == null) {
      return;
    }

    //모든 텍스트 폼 필드를 검사한 뒤 모두 에러가 없으면 TRUE
    if (formKey.currentState!.validate()) { //에러가 없을 때
      formKey.currentState!.save(); //저장.

      if (widget.diaryId == null) {
        await GetIt.I<LocalDatabase>().createDiary(
          DiaryCompanion(
            date: Value(widget.selectedDate),
            title: Value(title!),
            content: Value(content!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateDiaryById(
          widget.diaryId!,
          DiaryCompanion(
            date: Value(widget.selectedDate),
            title: Value(title!),
            content: Value(content!),
          ),
        );
      }

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Title extends StatelessWidget {
  final FormFieldSetter<String> onSavedTitle;
  final String initialValue;

  //일정 내용
  const _Title(
      {required this.onSavedTitle, required this.initialValue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      //내용
      label: '제목',
      isMemo: false,
      onSaved: onSavedTitle,
      initialValue: initialValue,
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSavedContent;
  final String initialValue;

  //일정 추가 메모
  const _Content({required this.onSavedContent, required this.initialValue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      //메모
      label: '내용',
      isMemo: true,
      onSaved: onSavedContent,
      initialValue: initialValue,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
            ),
            child: Text('일기 저장'),
          ),
        ),
      ],
    );
  }
}