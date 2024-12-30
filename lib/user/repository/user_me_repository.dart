import 'package:ahri_manager/common/dio/dio.dart';
import 'package:ahri_manager/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvier);
  return UserMeRepository(dio, baseUrl: 'http:///user/me');
}
);
//http://$ip/user/me
@RestApi()
abstract class UserMeRepository{
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/')
  @Headers({
    'accessToken':'true',
  })
  Future<UserModel> getMe();
}
