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
            if(userImage!=null)
              Image.file(userImage, height: 100, width: 100,),
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
                    });//
                  }
                },
              ),
            ),
            Padding( //이름
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
                  Text(
                    '성별',
                    style: TextStyle(fontSize: 17),
                  ),
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

            //Column으로 묶고 두개를 Row로 하면 될 거 같긴 한데 왜 안되는진 모르겠다 ㅏ아아!!!!!!!

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
                  Text(
                    '중성화',
                    style: TextStyle(fontSize: 17),
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
            Padding(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text('저장'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    onPressed: (){
                      if(weight.text==""||name.text==""){Text("하이dddddkdkjlakdjflkdsafjlkadsfjlaks;fjl;aksdjfl;asdjfklasdjflk;dsajflk;dsajflkas");}
                        else{
                        saveUserInformation();
                      }},
                  ),
                  ElevatedButton(
                    child: const Text('취소'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
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

  Future saveUserInformation() async{
    int selectedyear=selectedDate.year;
    int selectedmonth=selectedDate.month;
    int selectedday=selectedDate.day;
    user_information newUser_Information= user_information(
        1,
        name.text,
        weight.text,
        _genderbuttonText.toString(),
        selectedyear,
        selectedmonth,
        selectedday,
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
