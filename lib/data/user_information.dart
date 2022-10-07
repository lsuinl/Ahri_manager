// 사용자가 입력하는 동물 정보 관리

class user_information{
  int id=0;
  String name="";
  String weight="";
  String gender="";
  int selectedyear=0;
  int selectedmonth=0;
  int selectedday=0;
  String neu="";
  String species="";

  user_information(this.id,this.name,this.weight, this.gender, this.selectedyear,this.selectedmonth,this.selectedday, this.neu, this.species);

  user_information.fromJson(Map<String, dynamic> user_informationMap){
    id = user_informationMap['id'] ?? 0;
    name = user_informationMap['name'] ?? "";
    weight = user_informationMap['weight'] ?? "";
    gender = user_informationMap['gender'] ?? "";
    selectedyear = user_informationMap['selectedyear'] ?? 0;
    selectedmonth = user_informationMap['selectedmonth'] ?? 0;
    selectedday = user_informationMap['selectedday'] ?? 0;
    neu = user_informationMap['neu'] ?? "";
    species = user_informationMap['species'] ?? "";
  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'weight':weight,
      'gender':gender,
      'selectedyear':selectedyear,
      'selectedmonth':selectedmonth,
      'selectedday':selectedday,
      'neu':neu,
      'species':species
    };
  }

  }
