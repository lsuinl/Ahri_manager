import 'package:ahri_manager/common/dio/dio.dart';
import 'package:ahri_manager/user/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/data_utils.dart';

final authRepositoryProvider = Provider((ref){
  final dio = ref.watch(dioProvier);

  return AuthRepository(baseUrl: 'http:///auth', dio: dio);
});

class AuthRepository{
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });
  Future<LoginResponse>  login ({
    required String username,
    required String passward
  })async{
    final serialized = DataUtils.EncodingToUrl('$username:$passward');
    final resp  = await dio.post(
        '$baseUrl/login',
        options: Options(
            headers: {
              'quthorization':'Basic $serialized'
            }
        )
    );
    return LoginResponse.fromJson(
        resp.data
    );

  }
}