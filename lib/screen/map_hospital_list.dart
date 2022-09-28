import 'package:ahri_manager/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ahri_manager/data/hospital_information.dart';
import 'package:flutter/cupertino.dart';
import '../plus/user_helper.dart'; //데이터 가져오기

class Map_hospital_list extends StatefulWidget {
  const Map_hospital_list({Key? key}) : super(key: key);

  @override
  State<Map_hospital_list> createState() => _Map_hospital_listState();
}

class _Map_hospital_listState extends State<Map_hospital_list> {
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
    String animalspecies = user_infotmations.first.species;

    List<Widget> getlist() {
      List<Widget> textlist = [];
      for (int i = 0; i < hospitalinf.length; i++) {
        if (hospitalinf[i].animal.contains(animalspecies)) {
          textlist.add(Column(
              children: [
                Text("${hospitalinf[i].name}", style: TextStyle(fontSize: 17),),
                Text("${hospitalinf[i].phone}", style: TextStyle(fontSize: 17),),
                Text("${hospitalinf[i].adress}", style: TextStyle(fontSize: 12),),
                Text("${hospitalinf[i].animal.toString()}\n\n", style: TextStyle(fontSize: 17),),
                //이름순이면 순서대로, 거리순이면 거리계산해서
              ],
            ),
          );
        }
        //거리순으로 선택된경우에는 거리순으로 정렬(버블정렬)
        if(_sortText=="거리순"){
          for(int a=0;a<textlist.length;a++) {
            for(int b=a;b<textlist.length;b++) {
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
        title: Text("내 정보"),
        actions: [
      DropdownButton(
        items: _dropDownSpeciesItems,
        onChanged: (String? value) {
          setState(() {
            _sortText = value;
          });
        },
        value: _sortText,
      ),
      ],
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
