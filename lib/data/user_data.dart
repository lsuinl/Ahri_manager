class user_information{
  int id=0;
  String name="";
  String weight="";
  String gender="";
  String selecteddate="";
  String neu="";
  String species="";

  user_information(this.id,this.name,this.weight, this.gender, this.selecteddate, this.neu, this.species);

  user_information.fromJson(Map<String, dynamic> user_informationMap){
    id = user_informationMap['id'] ?? 0;
    name = user_informationMap['name'] ?? "";
    weight = user_informationMap['weight'] ?? "";
    gender = user_informationMap['gender'] ?? "";
    selecteddate = user_informationMap['selecteddate'] ?? DateTime(0,);
    neu = user_informationMap['neu'] ?? "";
    species = user_informationMap['species'] ?? "";
  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'weight':weight,
      'gender':gender,
      'selecteddate':selecteddate,
      'neu':neu,
      'species':species
    };
  }

  }
