/*
<동물 기본 정보 등록하기>
동물 사진 등록
이름, 성별, 생일, 몸무게, 중성화 여부
 */
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//초기 권한 및 정보설정
class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? _genderbuttonText;
  String? _neubuttonText;
  String? _speciesText;

  final UserHelper helper = UserHelper();

  var userImage;
  addUI(u) {
    userImage = u;
  } //이미지 띄우기

  List _GenderType = ['수컷', '암컷'];
  List _SurgeryMenu = ['O', 'X'];
  List _SpeciesList = ['앵무새', '햄스터', '토끼', '물고기', '도마뱀'];
  List<DropdownMenuItem<String>> _dropDownGenderItems =
      new List.empty(growable: true);
  List<DropdownMenuItem<String>> _dropDownSurItems =
      new List.empty(growable: true);
  List<DropdownMenuItem<String>> _dropDownSpeciesItems =
      new List.empty(growable: true);

  @override
  void initState() {
    helper.init();

    super.initState();
    for (var item in _GenderType) {
      _dropDownGenderItems
          .add(DropdownMenuItem(value: item, child: Text(item)));
    }
    for (var item in _SurgeryMenu) {
      _dropDownSurItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    for (var item in _SpeciesList) {
      _dropDownSpeciesItems
          .add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _genderbuttonText = _dropDownGenderItems[0].value;
    _neubuttonText = _dropDownSurItems[0].value;
    _speciesText = _dropDownSpeciesItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            '동물 등록하기',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'jua',
              fontSize: 28.0,
            ),
          ),
        ),
        centerTitle: true, //중간에 오도록
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Text(
              '더 자세한 정보를 위해 해당 동물 정보를 입력해주세요.',
              style: TextStyle(
                fontFamily: 'jua',
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: const Text(
                    '동물 이미지 올리기',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'jua',
                      fontSize: 23.0,
                    ),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () async {
                  var picker = ImagePicker();
                  dynamic image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      dynamic ui = File(image.path);
                      addUI(ui);
                    });
                  }
                  Widget userima() {
                    //저장한 이미지를 띄우는 친구였어요... 새로운 페이지로 띄우는 건 가능했는데요? 이 페이지 안에 띄우는 건 못하겠어요.
                    //서칭해서 찾아보니까 return Container(body:어쩌구)) 하던데 응 안돼
                    return Image.file(
                      userImage,
                      height: 100,
                      width: 100,
                    );

                  }
                },
              ),
            ),

            Padding(
              //이름
              padding: EdgeInsets.fromLTRB(40, 20, 150, 10),
              child: Row(
                children: <Widget>[
                  new Text(
                    "이름",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  new Text('        '),
                  new Flexible(
                      child: new TextField(
                    controller: name,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            Padding(
              //동물종
              padding: EdgeInsets.fromLTRB(26, 5, 30, 10),
              child: Row(
                children: [
                  Text(
                    '  동물종',
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  Text('         '),
                  DropdownButton(
                    style: TextStyle(fontFamily: 'jua'),
                    items: _dropDownSpeciesItems,
                    onChanged: (String? value) {
                      setState(() {
                        _speciesText = value;
                      });
                    },
                    value: _speciesText,
                  ),
                ],
              ),
            ),

            Padding(
              //성별
              padding: EdgeInsets.fromLTRB(30, 15, 30, 10),
              child: Row(
                children: [
                  Text(
                    '  성별',
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  Text('           '),
                  DropdownButton(
                    items: _dropDownGenderItems,
                    onChanged: (String? value) {
                      setState(() {
                        _genderbuttonText = value;
                      });
                    },
                    value: _genderbuttonText,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 5),
              child: Row(
                children: [
                  Text(
                    '  생일',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  Text('      '),
                  IconButton(
                    //생일
                    iconSize: 30.0,
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              height: 300.0,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: selectedDate,
                                maximumYear: DateTime.now().year,
                                maximumDate: DateTime.now(),
                                onDateTimeChanged: (DateTime date) {
                                  setState(() {
                                    selectedDate = date; //사용자가 선택한 날짜 저장
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.cake,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Text(
                    '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                ],
              ),
            ),

            Padding(
              //무게
              padding: EdgeInsets.fromLTRB(30, 17, 210, 0),
              child: Row(
                children: <Widget>[
                  new Text(
                    " 몸무게",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  new Text('       '),
                  new Flexible(
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      controller: weight,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  new Text(
                    "kg",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),

            Padding(
              //중성화여부
              padding: EdgeInsets.fromLTRB(30, 25, 30, 5),
              child: Row(
                children: [
                  Text(
                    '  중성화',
                    style: TextStyle(fontFamily: 'jua', fontSize: 20),
                  ),
                  Text('        '),
                  DropdownButton(
                    items: _dropDownSurItems,
                    onChanged: (String? value) {
                      setState(() {
                        _neubuttonText = value;
                      });
                    },
                    value: _neubuttonText,
                  ),
                ],
              ),
            ),

            //버튼
            Padding(
              padding: EdgeInsets.fromLTRB(120, 15, 100, 0),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text(
                      '저장',
                      style: TextStyle(
                        fontFamily: 'jua',
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      if (weight.text == "" || name.text == "") {
                        Text("하이");
                      } else {
                        saveUserInformation();
                      }
                    },
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  ElevatedButton(
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontFamily: 'jua',
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      // 앱 종료 기능(정보수정창인 경우에는 이전화면으로 돌아감.
                      if(weight.text!=""||name.text!=""){
                          Navigator.pop(context);
                      }
                      else
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Future saveUserInformation() async {
    int selectedyear = selectedDate.year;
    int selectedmonth = selectedDate.month;
    int selectedday = selectedDate.day;
    user_information newUser_Information = user_information(
        1,
        name.text,
        weight.text,
        _genderbuttonText.toString(),
        selectedyear,
        selectedmonth,
        selectedday,
        _neubuttonText.toString(),
        _speciesText.toString());
    helper.writeusesinformation(newUser_Information);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
