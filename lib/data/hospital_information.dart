import 'package:google_maps_flutter/google_maps_flutter.dart';

class information {
  late String name;
  late String phone;
  late LatLng xy;
  late List animal;
  late String adress;

  information(
      String name, String phone, LatLng xy, List animal, String adress) {
    this.name = name;
    this.phone = phone;
    this.xy = xy;
    this.animal = animal;
    this.adress = adress;
  }
}

List<information> hospitialinf = [
  information(
    "24시부평종합동물의료센터",
    "032-511-6836",
    LatLng(
      37.5025841,
      126.7216472,
    ),
    ['도마뱀', '토끼', '햄스터'],
    "대한민국 인천광역시 부평구 부평대로 138 2층",
  ),
  information(
    "24시지구촌동물메디컬센터",
    "02-869-7582",
    LatLng(
      37.4987491,
      126.8847737,
    ),
    ['토끼', '햄스터'],
    "대한민국 서울특별시 구로구 구로중앙로31길 30",
  ),
  information(
      "24시폴동물병원",
      "031-717-7558",
      LatLng(
        37.3705246,
        127.1075005,
      ),
      ['토끼', '햄스터'],
      "대한민국 경기도 성남시 분당구 성남대로 385 102호"),
  information(
      "25시종합동물병원",
      "0313781114",
      LatLng(
        37.1490582,
        127.0721971,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 오산시 성호대로 97"),
  information(
      "WE동물병원",
      "031-269-9975",
      LatLng(
        37.3081761,
        126.9896866,
      ),
      ['도마뱀', '토끼', '햄스터'],
      "대한민국 경기도 수원시 장안구 파장로 109"),
  information(
      "가람동물병원",
      "031-906-0976",
      LatLng(
        37.6542524,
        126.7789937,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 고양시 일산동구 강석로 156 선경상가 101호"),
  information(
      "개포별빛동물병원",
      "02-573-7582",
      LatLng(
        37.4763984,
        127.0463008,
      ),
      ['앵무새'],
      "대한민국 서울특별시 강남구 논현로 70 동성빌딩"),
  information(
      "고강동물병원",
      "032-683-5137",
      LatLng(
        37.5268451,
        126.8158044,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기 부천시 오정구 역곡로 473"),
  information(
      "고려종합동물병원",
      "02-575-7999",
      LatLng(
        37.4935677,
        127.0507717,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 강남구 선릉로 225 도곡렉슬아파트 렉슬상가 109호"),
  information(
      "공원옆동물병원",
      "02-2650-8275",
      LatLng(
        37.5173721,
        126.8652319,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울특별시 양천구 목동서로 349 목동센트럴프라자 104호"),
  information(
      "공항축산동물병원",
      "02-2663-8520",
      LatLng(
        37.563583,
        126.8076903,
      ),
      ['물고기', '앵무새'],
      "대한민국 서울특별시 강서구 개화동로29길 15"),
  information(
      "굿모닝동물병원",
      "02-2665-8256",
      LatLng(
        37.5763859,
        126.8129994,
      ),
      ['앵무새'],
      "대한민국 서울특별시 강서구 방화대로47가길 7 샤르망1차 103호"),
  information(
      "금강종합동물병원",
      "02-2686-8008",
      LatLng(
        37.4953416,
        126.8429191,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 구로구 경인로 196"),
  information(
      "금쪽금쪽금쪽반려동물병원",
      "031-944-9979",
      LatLng(
        37.704678,
        126.722809,
      ),
      ['토끼', '햄스터'],
      "경기 파주시 가재울로94번길 27"),
  information(
      "금천 24시 K동물의료센터",
      "0607-1415-2475",
      LatLng(
        37.456045,
        126.8995615,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울 금천구 시흥대로 251"),
  information(
      "노룬산동물병원",
      "02-464-2748",
      LatLng(
        37.5368792,
        127.0617852,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울 광진구 뚝섬로 462"),
  information(
      "다우동물병원",
      "031-985-7579",
      LatLng(
        37.6229156,
        126.6979541,
      ),
      ['토끼', '햄스터'],
      "대한민국 경기도 김포시 중봉로 4 다우동물병원"),
  information(
      "닥터스종합동물병원",
      "02-905-7588",
      LatLng(
        37.6291401,
        127.0578102,
      ),
      ['앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 노원구 월계로 336 상천빌딩 1층 닥터스종합동물병원"),
  information(
      "대치성심동물병원",
      "02-501-1139",
      LatLng(
        37.493456,
        127.0597594,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울특별시 강남구 남부순환로 2921 1층 69-1호"),
  information(
      "동물사랑병원",
      "032-323-8275",
      LatLng(
        37.5124841,
        126.753855,
      ),
      ['앵무새'],
      "대한민국 경기도 부천시 원미구 도약로 39"),
  information(
      "로얄종합동물병원",
      "033-766-7230",
      LatLng(
        37.3413366,
        127.9534235,
      ),
      ['토끼', '햄스터'],
      "대한민국 강원도 원주시 남원로 655"),
  information(
      "리베동물메디컬센터",
      "02-2604-0156",
      LatLng(
        37.5251751,
        126.8682309,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 양천구 오목로 280"),
  information(
      "맘스동물의료센터",
      "032-229-8275",
      LatLng(
        37.5052215,
        126.7511765,
      ),
      ['도마뱀'],
      "대한민국 경기도 부천시 원미구 길주로 80"),
  information(
      "메디포즈동물병원",
      "010-8995-6354",
      LatLng(
        37.591936,
        127.2285532,
      ),
      ['토끼', '햄스터'],
      "대한민국 경기도 남양주시 와부읍 석실로 200 1층 메디포즈동물병원"),
  information(
      "메디피쉬수산질병관리원",
      "070-4647-1224",
      LatLng(
        37.3201219,
        126.8448628,
      ),
      ['물고기'],
      "대한민국 경기도 안산시 상록구 화랑로 514 상가 2층 204호"),
  information(
      "물고기병원 수산질병관리원",
      "010-8960-6839",
      LatLng(
        37.6331134,
        127.0710645,
      ),
      ['물고기'],
      "대한민국 서울특별시 노원구 공릉로59길 15 405호"),
  information(
      "미소동물의료센터",
      "02-2603-0075",
      LatLng(
        37.544852,
        126.8368232,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 강서구 강서로 215 삼광빌딩"),
  information(
      "벨라동물병원",
      "02-859-8775",
      LatLng(
        37.5005388,
        126.8846046,
      ),
      ['앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 구로구 구로중앙로34길 30"),
  information(
      "새은평동물의료센터",
      "02-358-7566",
      LatLng(
        37.6074525,
        126.9221367,
      ),
      ['앵무새'],
      "대한민국 서울특별시 은평구 서오릉로 80"),
  information(
      "서울종합동물병원",
      "031-422-7565",
      LatLng(
        37.3977731,
        126.97754,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 안양시 동안구 흥안대로 492"),
  information(
      "서울종합동물병원본원",
      "02-888-8807",
      LatLng(
        37.4771943,
        126.9352519,
      ),
      ['앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 관악구 신림로 233"),
  information(
      "숲속동물병원",
      "02-492-9303",
      LatLng(
        37.5892125,
        127.0905471,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울특별시 중랑구 겸재로 207"),
  information(
      "신세계동물병원",
      "054-273-9636",
      LatLng(
        36.0151371,
        129.3709135,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경북 포항시 남구 중앙로 20-1"),
  information(
      "신세계동물의료센터",
      "055-367-9123",
      LatLng(
        37.2390535,
        127.3253153,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 용인시 처인구 양지면 새실로"),
  information(
      "아크리스동물의료센터",
      "02-583-7582",
      LatLng(
        37.5136773,
        127.0618982,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 강남구 봉은사로104길 10 동화빌딩 3층"),
  information(
      "어울림동물병원",
      "02-305-4242",
      LatLng(
        37.573616,
        126.916407,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "서울 서대문구 가재울미래로 2 DMC 파크뷰자이 104동 1층 102A호"),
  information(
      "에코동물병원",
      "02-443-2222",
      LatLng(
        37.4927329,
        127.1280761,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 송파구 동남로 161 청공빌딩 101호"),
  information(
      "연서동동물종합병원",
      "02-358-7582",
      LatLng(
        37.6131681,
        126.9178498,
      ),
      ['도마뱀', '토끼', '햄스터'],
      "대한민국 서울특별시 은평구 연서로 162"),
  information(
      "예은동물병원",
      "02-529-5575",
      LatLng(
        37.4923809,
        127.0400194,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 강남구 도곡로 189 1층"),
  information(
      "오석헌동물병원",
      "02-6402-0301",
      LatLng(
        37.5451492,
        127.0141611,
      ),
      ['앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 성동구 매봉길 15 래미안 옥수 리버젠"),
  information(
      "우신종합동물병원",
      "02-836-6509",
      LatLng(
        37.5071693,
        126.9112269,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울특별시 영등포구 신길로 168 1층"),
  information(
      "이솝동물메디컬",
      "055-748-7500",
      LatLng(
        35.1784006,
        128.0974023,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "경남 진주시 남강로309번길 20"),
  information(
      "이앤박동물병원",
      "02-939-6898",
      LatLng(
        37.6652688,
        127.0665438,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울특별시 노원구 한글비석로52길 18"),
  information(
      "이지훈동물병원",
      "031-295-5975",
      LatLng(
        37.2761766,
        126.9786051,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 수원시 권선구 금호로 261"),
  information(
      "인덕원종합동물병원",
      "031-426-0075",
      LatLng(
        37.3982624,
        126.9763994,
      ),
      ['토끼', '햄스터'],
      "대한민국 경기도 안양시 동안구 흥안대로 495"),
  information(
      "일산시티동물의료센터",
      "031-932-0085",
      LatLng(
        37.660119,
        126.7664489,
      ),
      ['앵무새', '토끼', '햄스터'],
      "대한민국 경기도 고양시 일산동구 무궁화로 8-28 삼성메르헨하우스 1층"),
  information(
      "조은동물병원",
      "054-277-7535",
      LatLng(
        36.0248597,
        129.3595406,
      ),
      ['토끼', '햄스터'],
      "경북 포항시 남구 중흥로 124"),
  information(
      "죽전동물병원",
      "031-266-2993",
      LatLng(
        37.3207062,
        127.1144354,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 경기도 용인시 기흥구 죽전로 49 씨티프라자 101호"),
  information(
      "청라라임동물병원",
      "032-563-1900",
      LatLng(
        37.5366477,
        126.6534751,
      ),
      ['도마뱀', '토끼', '햄스터'],
      "대한민국 인천 서구 라임로 102"),
  information(
      "최영민동물의료센터",
      "02-546-9539",
      LatLng(
        37.5151461,
        127.032368,
      ),
      ['물고기', '도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 강남구 논현로132길 24 양현빌딩2층 최영민동물의료센터"),
  information(
      "충북대학교 동물병원",
      "043-261-2602",
      LatLng(
        36.6233247,
        127.4559218,
      ),
      ['물고기', '도마뱀', '앵무새', '토끼', '햄스터'],
      "충북 청주시 서원구 충대로 1 충북대학교 수의과대학 동물의료센터"),
  information(
      "케나인동물병원",
      "042-487-7555",
      LatLng(
        36.3487488,
        127.399673,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 대전광역시 서구 둔산남로 200"),
  information(
      "탑케어동물의료원",
      "1666-7501",
      LatLng(
        37.6311912,
        126.8310468,
      ),
      ['도마뱀', '토끼', '햄스터'],
      "대한민국 경기도 고양시 덕양구 화신로272번길 5"),
  information(
      "태전동물병원",
      "053-357-7588",
      LatLng(
        35.9290044,
        128.5474052,
      ),
      ['토끼', '햄스터'],
      "대한민국 대구 북구 칠곡중앙대로 373"),
  information(
      "파우동물병원",
      "031-898-0330",
      LatLng(
        37.3321847,
        127.1235368,
      ),
      ['도마뱀', '토끼', '햄스터'],
      "대한민국 경기도 용인시 수지구 현암로125번길 6 그린프라자 105호"),
  information(
      "하나동물병원",
      "02-6242-7500",
      LatLng(
        37.5894645,
        127.0609308,
      ),
      ['토끼', '햄스터'],
      "대한민국 서울 동대문구 망우로 66"),
  information(
      "한성동물병원",
      "02-872-7609",
      LatLng(
        37.4782212,
        126.9318251,
      ),
      ['물고기', '도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 관악구 신림로 265"),
  information(
      "한수동물병원",
      "02-306-8575",
      LatLng(
        37.5817478,
        126.9070339,
      ),
      ['앵무새'],
      "대한민국 서울특별시 은평구 증산로 267 1층"),
  information(
      "한양동물메디컬센터",
      "02-2281-5200",
      LatLng(
        37.5596166,
        127.0369899,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 서울특별시 성동구 왕십리로 282"),
  information(
      "황학균동물병원",
      "042-822-4775",
      LatLng(
        36.3451008,
        127.339087,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 대전 유성구 상대동로2번길"),
  information(
      "실험용",
      "042-822-4775",
      LatLng(
        37.22310017857214,
        127.1873556838689,
      ),
      ['도마뱀', '앵무새', '토끼', '햄스터'],
      "대한민국 대전 유성구 상대동로2번길"),
];
