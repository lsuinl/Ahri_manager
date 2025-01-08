import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../common/recure_storage/recure_storage.dart';
import '../../common/utils/data.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier,UserModelBase?>((ref){
  final authRepository = ref.watch(authRepositoryProvider);
  final UserMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRepository: authRepository,
      repository: UserMeRepository,
      storage: storage
  );
}

);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try{
      state = UserModelLoading();

      final resp = await authRepository.login(
          username:username,
          passward:password
      );

      await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;

      return userResp;
    }
    catch(e){
      state = UserModelError(message: "로그인에 실패하였습니댜.");

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null; //바로 null로 만들어서 로그인페이지로 보내기

    await storage.delete(key: ACCESS_TOKEN_KEY);
  }
}