/*
<동물 기본 정보 등록하기>
동물 사진 등록
이름, 성별, 생일, 몸무게, 중성화 여부
 */

import 'package:flutter/material.dart';
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
  TextEditingController birth = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController neutral = TextEditingController();

  var userImage;
  List _GenderType = ['수컷', '암컷'];
  List _SurgeryMenu = ['O', 'X'];
  List<DropdownMenuItem<String>> _dropDownGenderItems =
  new List.empty(growable: true);
  List<DropdownMenuItem<String>> _dropDownSurItems =
  new List.empty(growable: true);
  String? _genderbuttonText;
  String? _neubuttonText;

  @override
  void initState() {
    super.initState();
    for (var item in _GenderType) {
      _dropDownGenderItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    for (var item in _SurgeryMenu) {
      _dropDownSurItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _genderbuttonText = _dropDownGenderItems[0].value;
    _neubuttonText = _dropDownSurItems[0].value;
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
                  var image =
                  await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      userImage = File(image.path);
                    });
                  }
                },
              ),
            ),
            //Image.file(userImage),
            Padding(//이름
              padding: EdgeInsets.fromLTRB(100, 10, 30, 30),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 30, 10),
              child: Text('성별'),
            ),

            Padding(//성별
              padding: EdgeInsets.fromLTRB(100, 10, 30, 5),
              child: DropdownButton(
                items: _dropDownGenderItems,
                onChanged: (String? value) {
                  setState(() {
                    _genderbuttonText = value;
                  });
                },
                value: _genderbuttonText,
              ),
            ),

            Padding(//생일
              padding: EdgeInsets.fromLTRB(100, 20, 30, 5),
              child: Row(
                children: <Widget>[
                  TextField(
                    controller: birth,
                    decoration: InputDecoration(
                      labelText: 'Birth',
                    ),
                  ),
                ],
              ),
            ),


            Padding(//무게
              padding: EdgeInsets.fromLTRB(100, 30, 30, 5),
              child: TextField(
                controller: weight,
                decoration: InputDecoration(
                  labelText: 'Weight',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 30, 30, 5),
              child: Text('중성화'),
            ),
            Padding(//중성화여부
              padding: EdgeInsets.fromLTRB(100, 10, 30, 5),
              child: DropdownButton(
                items: _dropDownSurItems,
                onChanged: (String? value) {
                  setState(() {
                    _neubuttonText = value;
                  });
                },
                value: _neubuttonText,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                child: const Text('저장'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  //if
                },
              ),
            ),
          ],
        ));
  }
}