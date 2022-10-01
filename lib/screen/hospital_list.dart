import 'package:ahri_manager/data/user_information.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ahri_manager/data/hospital_information.dart';
import 'package:flutter/cupertino.dart';
import '../plus/user_helper.dart'; //데이터 가져오기

class MapHospitalListScreen extends StatefulWidget {
  const MapHospitalListScreen({Key? key}) : super(key: key);

  @override
  State<MapHospitalListScreen> createState() => _MapHospitalListScreenState();
}

class _MapHospitalListScreenState extends State<MapHospitalListScreen> {
  GoogleMapController? mapController;
  List<information> hospitalinf = [];
  List<user_information> user_infotmations = [];
  final UserHelper helper = UserHelper();
  List _SpeciesList = ['이름순', '거리순'];
  List<DropdownMenuItem<String>> _dropDownSpeciesItems =
      new List.empty(growable: true);
  String? _sortText;

  @override
  void initState() {
    hospitalinf = hospitialinf;
    helper.init().then((value) {
      updateScreen();
    });
    for (var item in _SpeciesList) {
      _dropDownSpeciesItems
          .add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _sortText = _dropDownSpeciesItems[0].value;
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    String animalspecies="";
    if(user_infotmations.isNotEmpty) {
       animalspecies = user_infotmations.first.species;
    }
    List<Widget> getlist() {
      List<Widget> textlist = [];
      for (int i = 0; i < hospitalinf.length; i++) {
        if (hospitalinf[i].animal.contains(animalspecies)) {
          textlist.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    "${hospitalinf[i].name}", //병원명
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'jua',
                    ),
                  ),
                  Text(
                    "${hospitalinf[i].phone}", //전화번호
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'jua',
                    ),
                  ),
                  Text(
                    "${hospitalinf[i].adress}", //주소
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'jua',
                    ),
                  ),
                  Text(
                    "${hospitalinf[i].animal.toString()}\n\n", //동물
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'jua',
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 500.0,
                    color: Colors.black12,
                  ),
                  //이름순이면 순서대로, 거리순이면 거리계산해서
                ],
              ),
            ),
          );
        }
        //거리순으로 선택된경우에는 거리순으로 정렬(버블정렬)
        if (_sortText == "거리순") {
          for (int a = 0; a < textlist.length; a++) {
            for (int b = a; b < textlist.length; b++) {
              Widget temporary;
              // if(){}
            }
          }
        }
      }
      return textlist;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "병원 목록",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'jua',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: DropdownButton(
              style: TextStyle(
                fontFamily: 'jua',
                fontSize: 17.0,
                color: Colors.black,
              ),
              items: _dropDownSpeciesItems,
              onChanged: (String? value) {
                setState(() {
                  _sortText = value;
                });
              },
              value: _sortText,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: getlist(),
      ),
    );
  }

  void updateScreen() {
    user_infotmations = helper.getuserinformation();
    setState(() {});
  }

//현재좌표 가져오기
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}

//------------------------------------------------------
// 권한과 관련된 모든 값은 미래의 값을 받아오는 async로 작업
