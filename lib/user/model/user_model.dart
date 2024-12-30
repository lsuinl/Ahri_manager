import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


//유저정보를 담는 모델
//베이스, 에러, 로딩, 기본 네가지를 기준으로 함
abstract class UserModelBase{}

class UserModelLoading extends UserModelBase{}

class UserModelError extends UserModelBase{
  final String message;

  UserModelError({
    required this.message
});
}

@JsonSerializable()
class UserModel extends UserModelBase{
  final String username;
  final String email;

  UserModel({
    required this.username,
    required this.email
});
  factory UserModel.fromJson(Map<String,dynamic> json)
  => _$UserModelFromJson(json);
}