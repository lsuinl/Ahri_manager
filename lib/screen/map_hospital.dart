import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ahri_manager/data/hospital_information.dart'; //데이터 가져오기

class Map_hospital extends StatefulWidget {
  const Map_hospital({Key? key}) : super(key: key);

  @override
  State<Map_hospital> createState() => _Map_hospitalState();
}


class _Map_hospitalState extends State<Map_hospital> {
  Set<Marker> _markers=new Set();
  GoogleMapController? mapController;


  @override
  Widget build(BuildContext context) {
    //마커. map를 활용한 넘버.
    for(int i=0; i<6;i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(
          37.223+i-0.99,
          127.1873556838689,
        ),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                    ],
                  ),
                ),
              );
            }, // builder
          );
        },
        infoWindow: InfoWindow(
          title: "안녕하세요",
        ),
      ));
    }
    return Scaffold(
        appBar: AppBar(
          //타이틀
          title: Text(
            '지도찾기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.pink,
        ),
        body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //로딩중,,
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            //권한을 얻었을 시에 작동
            if (snapshot.data == '위치 권한이 허가되었습니다.') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(), //내 현재위치 가져오기
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                      Expanded(
                      flex: 3,
                      child: GoogleMap(
                        initialCameraPosition:  CameraPosition(
                                target: LatLng(
                                  37.22310017857214,
                                  127.1873556838689,
                                ),zoom: 15),
                        //초기 카메라 위치
                        myLocationEnabled: true,
                        //내위치표시
                        myLocationButtonEnabled: true,
                        //내위치로가기버튼
                        mapType: MapType.normal,
                        //맵타입형식 위성지도 등등 설정 가능, //**************************
                        //줌 동작 활성화
                        zoomGesturesEnabled: true,
                        //컨트롤러 조작
                        onMapCreated: onMapCreated,
                        markers: _markers,
                      ),
                    ),
                        // _CustomGoogleMap(
                        //   onmapcreated: onMapCreated, //컨트롤러설정
                        //   marker: list, //마커
                        //   initialPostion: CameraPosition(
                        //       target: LatLng(
                        //         37.22310017857214,
                        //         127.1873556838689,
                        //       ),
                        //       zoom: 15), //초기 위치
                        // ),
                      ],
                    );
                  });
            }
            //권한 설정이 안 되어있는 경우
            return Center(
              child: Text(snapshot.data),
            );
          },
        ));
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}

//------------------------------------------------------
// 권한과 관련된 모든 값은 미래의 값을 받아오는 async로 작업
Future<String> checkPermission() async {
  //권한 확인
  final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isLocationEnabled) {
    return '위치 서비스를 활성화 해주세요.';
  }
  //현재 앱이 가지고 있는 위치서비스에 대한 권한 값을 location이라는 형식으로 반환
  LocationPermission checkPermission = await Geolocator.checkPermission();
  if (checkPermission == LocationPermission.denied) {
    //권한을 사용할 수 없지만 요청할 수는 있는 경우
    checkPermission = await Geolocator.requestPermission();

    if (checkPermission == LocationPermission.denied) {
      return '위치 권한을 설정합니다';
    }
  }
  if (checkPermission == LocationPermission.deniedForever) {
    return '앱의 위치 권한을 설정에서 허가해주세요';
  }
  return '위치 권한이 허가되었습니다.';
}
