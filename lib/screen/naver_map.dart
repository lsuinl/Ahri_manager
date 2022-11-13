import 'dart:async';
import 'package:ahri_manager/data/user_information.dart';
import 'package:ahri_manager/data/hospital_information.dart';
import 'package:ahri_manager/plus/user_helper.dart';
import 'package:ahri_manager/screen/hospital_list.dart';
import 'package:flutter/services.dart'; //머에쓰는고
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class naver extends StatefulWidget {
  const naver({Key? key}) : super(key: key);

  @override
  State<naver> createState() => _naverState();
}

class _naverState extends State<naver> {
  List<Marker> _markers = [];
  NaverMapController? mapController;
  List<information> hospitalinf = [];
  List<user_information> user_informations = [];
  final UserHelper helper = UserHelper();
  LatLng mylocation = LatLng(0, 0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();
  late OverlayImage markerIcon;

  //커스텀 마커디자인
  void setCustomMapPin() async {
    markerIcon = await OverlayImage.fromAssetImage(
        assetName: 'asset/imgs/marker.png',
    );
  }

  @override
  void initState() {
    hospitalinf = hospitialinf; //병원리스트
    helper.init().then((value) {
      updateScreen();
    });
    getCurrentLocation(); //내위치 가져오기
    setCustomMapPin(); //커스텀마거적용
    super.initState();
  }

  @override
  //병원 정보 가져오기+마커화
  Widget build(BuildContext context) {
    String animalspecies = "";
    if (user_informations.isNotEmpty) {
      animalspecies = user_informations.first.species;
    }

    for (int i = 0; i < hospitalinf.length; i++) {
      if (hospitalinf[i].animal.contains(animalspecies)) {
        _markers.add(Marker(
          markerId: (hospitalinf[i].name),
          position: LatLng(
            hospitalinf[i].xy.latitude,
            hospitalinf[i].xy.longitude,
          ),
          icon: markerIcon,
          onMarkerTab: (Marker? marker, Map<String, int?> iconSize) { //마커선택 시 탭 활성화
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('asset/imgs/pattern1.png',),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${hospitalinf[i].name}",
                        style: TextStyle(
                          fontFamily: 'jua',
                          fontSize: 20.0,
                          color: Colors.brown,
                        ),
                      ),
                      new TextButton(
                        onPressed: () =>
                            launchUrl(Uri.parse(
                                'tel:${hospitalinf[i].phone.replaceAll(
                                    "-", "")}')),
                        child: new Text(
                          "${hospitalinf[i].phone}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'jua',
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        "${hospitalinf[i].adress}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'jua',
                          fontSize: 20.0,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  //),
                );
              }, // builder
            );
          },
          infoWindow: hospitalinf[i].name,
        ));
      }
    }

    //화면구성
    return Scaffold(
        appBar: AppBar( //상단:앱바
          title: Text(
            '병원찾기',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'jua',
              fontSize: 30.0,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.red[100],
          centerTitle: true,
          actions: [ //인근병원찾기버튼
            TextButton(
              onPressed: () {
                LatLng initlocation = LatLng(0, 0);
                for (int i = 0; i < hospitalinf.length; i++) {
                  if (hospitalinf[i].animal.contains(animalspecies)) {
                    if (((mylocation.latitude - initlocation.latitude).abs() +
                        (mylocation.longitude - initlocation.longitude)
                            .abs()) >
                        ((mylocation.latitude - hospitalinf[i].xy.latitude)
                            .abs() +
                            (mylocation.longitude - hospitalinf[i].xy.longitude)
                                .abs())) {
                      initlocation = hospitalinf[i].xy;
                    }
                  }
                }
                  mylocation=initlocation;
                  print(mylocation );
                  CameraUpdate cameraupdate =CameraUpdate.scrollTo(initlocation);
                  if(mapController!=null){
                    mapController!.moveCamera(cameraupdate);
                  }

              },
              child: Text(
                "인근병원찾기",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'jua',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder<Position>(
            stream: Geolocator.getPositionStream(), //내 현재위치 가져오기
            builder: (context, snapshot) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: NaverMap(
                      initLocationTrackingMode: LocationTrackingMode.Follow, //초기위치는 내위치
                      logoClickEnabled: true, //로고
                      locationButtonEnable: true,//내위치로버툰
                      mapType: MapType.Basic, //맵타입
                      onMapCreated:  _onMapCreated, //콜백 조작
                      markers: _markers,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HospitalListScreen(
                                    mylocation: mylocation,
                                  )
                          ));
                    },
                    child: Text(
                      "리스트로 보기",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'jua',),
                    ),
                  )
                ],
              );
            })
    );
  }

  void _onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
    mapController=controller; //하,,,니놈이구나
  }

  //현재위치 가져오기
  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    setState(() {
      mylocation = LatLng(position.latitude, position.longitude);
    });
  }
  //초기정보업데이트
  void updateScreen() {
    user_informations = helper.getuserinformation();
    setState(() {});
  }
}
