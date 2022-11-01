// // 병원의 위치와 정보를 지도를 통해 볼 수 있는 맵 스크린
//
// import 'package:ahri_manager/data/user_information.dart';
// import 'package:ahri_manager/screen/hospital_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ahri_manager/data/hospital_information.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../plus/user_helper.dart';
// // import 'dart:ui' as ui;
//
//
// class HospitalMapScreen extends StatefulWidget {
//   const HospitalMapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HospitalMapScreen> createState() => _HospitalMapScreenState();
// }
//
// class _HospitalMapScreenState extends State<HospitalMapScreen> {
//   Set<Marker> _markers = new Set();
//   GoogleMapController? mapController;
//   List<information> hospitalinf = [];
//   List<user_information> user_infotmations = [];
//   final UserHelper helper = UserHelper();
//   LatLng mylocation = LatLng(0, 0);
//   Uint8List markerIcon=Uint8List(0);//초기화
//
//   @override
//   void initState() {
//     hospitalinf = hospitialinf;
//     helper.init().then((value) {updateScreen();});
//     getCurrentLocation();
//     super.initState();
//     // setcustommappin();
//   }
//
//   // void setcustommappin() async {
//   //   markerIcon = await getbytesfromasset('asset/imgs/hospitalmarker.png', 100);
//   // }
//   //
//   // Future<Uint8List> getbytesfromasset(String path, int width) async{
//   //   ByteData data= await rootBundle.load(path);
//   //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//   //       targetWidth: width);
//   //   ui.FrameInfo fi = await codec.getNextFrame();
//   //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
//   //       !.buffer
//   //       .asUint8List();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     String animalspecies = "";
//     if (user_infotmations.isNotEmpty) {
//       animalspecies = user_infotmations.first.species;
//     }
//
//     for (int i = 0; i < hospitalinf.length; i++) {
//       if (hospitalinf[i].animal.contains(animalspecies)) {
//         _markers.add(Marker(
//           markerId: MarkerId(hospitalinf[i].name),
//           // icon: BitmapDescriptor.fromBytes(markerIcon),
//           position: LatLng(
//             hospitalinf[i].xy.latitude,
//             hospitalinf[i].xy.longitude,
//           ),
//           onTap: () {
//             showModalBottomSheet<void>(
//               context: context,
//               builder: (context) {
//                 return Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('asset/imgs/pattern1.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text(
//                           "${hospitalinf[i].name}",
//                           style: TextStyle(
//                             fontFamily: 'jua',
//                             fontSize: 20.0,
//                             color: Colors.brown,
//                           ),
//                         ),
//                         new TextButton(
//                           onPressed: () => launchUrl(Uri.parse(
//                               'tel:${hospitalinf[i].phone.replaceAll("-", "")}')),
//                           child: new Text(
//                             "${hospitalinf[i].phone}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'jua',
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "${hospitalinf[i].adress}",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: 'jua',
//                             fontSize: 20.0,
//                             color: Colors.brown,
//                           ),
//                         ),
//                       ],
//                     ),
//                   //),
//                 );
//               }, // builder
//             );
//           },
//           infoWindow: InfoWindow(
//             title: hospitalinf[i].name,
//           ),
//         ));
//       } //if
//     } //for
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             '병원찾기',
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'jua',
//               fontSize: 30.0,
//               shadows: [
//                 Shadow(
//                   blurRadius: 10.0,
//                   color: Colors.black,
//                   offset: Offset(1.0, 1.0),
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: Colors.red[100],
//           centerTitle: true,
//           actions: [
//             TextButton(
//               onPressed: () {
//                 LatLng initlocation = LatLng(0, 0);
//                 for (int i = 0; i < hospitalinf.length; i++) {
//                   if (hospitalinf[i].animal.contains(animalspecies)) {
//                     if (((mylocation.latitude - initlocation.latitude).abs() +
//                             (mylocation.longitude - initlocation.longitude)
//                                 .abs()) >
//                         ((mylocation.latitude - hospitalinf[i].xy.latitude)
//                                 .abs() +
//                             (mylocation.longitude - hospitalinf[i].xy.longitude)
//                                 .abs())) {
//                       initlocation = hospitalinf[i].xy;
//                     }
//                   }
//                 }
//                 mapController!.animateCamera(CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     target: LatLng(initlocation.latitude, initlocation.longitude),
//                     zoom: 11.0,
//                   ),
//                 ));
//               },
//               child: Text(
//                 "인근병원찾기",
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontFamily: 'jua',
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body:StreamBuilder<Position>(
//                   stream: Geolocator.getPositionStream(), //내 현재위치 가져오기
//                   builder: (context, snapshot) {
//                     return Column(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: GoogleMap(
//                             initialCameraPosition: CameraPosition(
//                               target: LatLng(37.564214, 127.001699),
//                               zoom: 11,
//                             ),       //초기 카메라 위치
//                             myLocationEnabled: true,     //내위치표시
//                             myLocationButtonEnabled: true,     //내위치로가기버튼
//                             mapType: MapType.normal,  //맵타입형식
//                             zoomGesturesEnabled: true, //줌 동작 활성화
//                             onMapCreated: onMapCreated,    //컨트롤러 조작
//                             markers: _markers,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HospitalListScreen(
//                                           mylocation: mylocation,
//                                         )));},
//                           child: Text(
//                             "리스트로 보기",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20.0,
//                               fontFamily: 'jua',),
//                           ),
//                         )
//                       ],
//                     );
//                   })
//             );
//   }
//
//   onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.low);
//     print(position);
//     setState(() {
//       mylocation = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//   void updateScreen() {
//     user_infotmations = helper.getuserinformation();
//     setState(() {});
//   }
// }
