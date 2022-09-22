import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_hospital extends StatefulWidget {
  const Map_hospital({Key? key}) : super(key: key);

  @override
  State<Map_hospital> createState() => _Map_hospitalState();
}

class _Map_hospitalState extends State<Map_hospital> {
  GoogleMapController? mapController;

  //latitude -위도, longitude-경도
  //병원좌표
  static final LatLng companyLatlng = LatLng(
    37.22310017857214,
    127.1873556838689,
  );
  //?
  static final double okdistance = 100;
  //마커.
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatlng,
  );

  //줌 레벨(확대된 정도)설정, 초기위치.설정
  static final CameraPosition initionlposition = CameraPosition(
    target: companyLatlng,
    zoom: 15,
  );
//-----------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == '위치 권한이 허가되었습니다.') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      final start = snapshot.data!;
                      final end = companyLatlng; //현재 회사의 위치.
                      //start와 end 둘 사이의 거리가 100m 미만이 맞는지 확인.

                      final distance = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude,
                      );
                    }

                    return Column(
                      children: [
                        _CustomGoogleMap(
                          onmapcreated: onMapCreated,
                          marker: marker,
                          initialPostion: initionlposition,
                        ),
                      ],
                    );
                  }
              );
            }
            return Center(
              child: Text(snapshot.data),
            );
          },
        )
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      //타이틀
      title: Text(
        '지도찾기',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPostion;
  final Marker marker;
  final MapCreatedCallback onmapcreated;
  const _CustomGoogleMap(
      {required this.initialPostion,
        required this.onmapcreated,
        required this.marker,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GoogleMap(
        initialCameraPosition: initialPostion, //초기 카메라 위치
        myLocationEnabled: true, //내위치표시
        myLocationButtonEnabled: true, //내위치로가기버튼(커스텀할 예정)
        mapType: MapType.normal, //맵타입형식 위성지도 등등 설정 가능
        markers: Set.from([marker]),
        onMapCreated: onmapcreated,
      ),
    );
  }
}


// 권한과 관련된 모든 값은 미래의 값을 받아오는 async로 작업
//*****가능하면 start.dart에서 미리 권한 요청 허가 받아놓을 것.
Future<String> checkPermission() async {
  //권한을 사용할 수 있는지를 확인
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
      return '위치 권한을 허가해주세요';
    }
  }
  if (checkPermission == LocationPermission.deniedForever) {
    return '앱의 위치 권한을 셋팅에서 허가해주세요';
  }
  return '위치 권한이 허가되었습니다.';
}
