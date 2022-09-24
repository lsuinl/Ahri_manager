/*
<동물 기본 정보 등록하기>
동물 사진 등록
이름, 성별, 생일, 몸무게, 중성화 여부
 */
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/data/user_data.dart';
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

  final UserHelper helper =UserHelper();

  var userImage;
  addUI(u) {userImage = u;} //이미지 띄우기

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
      _dropDownSpeciesItems.add(DropdownMenuItem(value: item, child: Text(item)));
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
        title: Text('동물 등록하기'),
        centerTitle: true, //중간에 오도록
        leading: Icon(Icons.home),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                child: const Text('이미지를 올리쇼'),
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
                  Widget userima(){ //저장한 이미지를 띄우는 친구였어요... 새로운 페이지로 띄우는 건 가능했는데요? 이 페이지 안에 띄우는 건 못하겠어요.
                    //서칭해서 찾아보니까 return Container(body:어쩌구)) 하던데 응 안돼
                    return Image.file(userImage, height: 100, width: 100,);
                  }
                },
              ),
            ),
            Padding(
              //이름
              padding: EdgeInsets.fromLTRB(100, 10, 30, 20),
              child: TextField(
                controller: name, //name
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding( //동물종
              padding: EdgeInsets.fromLTRB(26, 5, 30, 10),
              child: Row(
                children: [
                  Text('동물종', style: TextStyle(fontSize: 17),),
                  Text('           '),
                  DropdownButton(
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
              padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
              child: Row(
                children: [
                  Text('성별', style: TextStyle(fontSize: 17),),
                  Text('          '),
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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Row(
                children: [
                  Text(
                    '생일',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text('      '),
                  IconButton( //생일
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
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),


            Padding(//무게
              padding: EdgeInsets.fromLTRB(100, 10, 30, 0),
              child: Column(
                children: [
                  Text('몸무게'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: weight,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                    ),
                  ),
                  Text(
                    'Kg',
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            Padding(
              //중성화여부
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              child: Row(
                children: [
                  Text('중성화', style: TextStyle(fontSize: 17),),
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
            Padding(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('저장'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    onPressed: () {saveUserInformation();
                      },
                  ),
                  ElevatedButton(
                    child: const Text('취소'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      // 앱 종료 기능
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Future saveUserInformation() async{
    String selecteddate= '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    user_information newUser_Information= user_information(
        1,
        name.text,
        weight.text,
        _genderbuttonText.toString(),
        selecteddate,
        _neubuttonText.toString(),
        _speciesText.toString()
    );
    helper.writeusesinformation(newUser_Information);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
