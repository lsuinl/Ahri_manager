import 'dart:collection';
import 'package:ahri_manager/data/user_information.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ahri_manager/data/hospital_information.dart';
import 'package:flutter/cupertino.dart';
import '../plus/user_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalListScreen extends StatefulWidget {
  final LatLng mylocation;

  const HospitalListScreen({required this.mylocation, Key? key})
      : super(key: key);

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  GoogleMapController? mapController;
  List<information> hospitalinf = [];
  List<user_information> user_infotmations = [];
  final UserHelper helper = UserHelper();
  List _SpeciesList = ['이름순', '거리순'];
  List<DropdownMenuItem<String>> _dropDownSpeciesItems =
      new List.empty(growable: true);
  String? _sortText;
  LatLng mylocation = LatLng(0, 0);

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
    mylocation = widget.mylocation;
    _sortText = _dropDownSpeciesItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String animalspecies = "";
    if (user_infotmations.isNotEmpty) {
      animalspecies = user_infotmations.first.species;
    }

    List<Widget> getlist() {
      List<Widget> textnamelist = [];
      List<Widget> textdistancelist = [];
      for (int i = 0; i < hospitalinf.length; i++) {
        if (hospitalinf[i].animal.contains(animalspecies)) {
          textnamelist.add(
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
                  new TextButton(
                      onPressed: () => launchUrl(Uri.parse(
                          'tel:${hospitalinf[i].phone.replaceAll("-", "")}')),
                      child: new Text(
                        "${hospitalinf[i].phone}",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'jua',
                        ),
                      )),
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
                  //거리측정해서 int형 배열에 순위 저장
                ],
              ),
            ),
          );
        }
      }

      Map<int, double> list = {};
      for (int i = 0; i < hospitalinf.length; i++) {
        if (hospitalinf[i].animal.contains(animalspecies)) {
          //map에 해당 동물이 있는 위치 i 와 거리를 key와 value로 저장
          list[i] = (mylocation.latitude - hospitalinf[i].xy.latitude).abs() +
              (mylocation.longitude - hospitalinf[i].xy.longitude).abs();
        }
      }
      //거리순으로 정렬된 map
      var sortedKeys = list.keys.toList(growable: false)
        ..sort((k1, k2) => list[k1]!.compareTo(list[k2]!));
      LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => list[k]);
      sortedMap.forEach((key, value) {
        textdistancelist.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: [
                SizedBox(height: 8.0),
                Text(
                  "${hospitalinf[key].name}", //병원명
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'jua',
                  ),
                ),
                new TextButton(
                  onPressed: () => launchUrl(Uri.parse(
                      'tel:${hospitalinf[key].phone.replaceAll("-", "")}')),
                  child: new Text(
                    "${hospitalinf[key].phone}",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'jua',
                      color: Colors.red,  // 왜안먹?혀? --> 이름순 말고 거리순으로 하면 먹힘 이름순은 안먹힘 어이 x
                    ),
                  ),
                ),
                Text(
                  "${hospitalinf[key].adress}", //주소
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'jua',
                  ),
                ),
                Text(
                  "${hospitalinf[key].animal.toString()}\n\n", //동물
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
              ],
            ),
          ),
        );
      });

      if (_sortText == '이름순') {
        return textnamelist;
      } else if (_sortText == '거리순') {
        return textdistancelist;
      }
      return textdistancelist;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "병원 목록",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'jua',
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                ),
              ],
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
}
