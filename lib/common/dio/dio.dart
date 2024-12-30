import 'package:ahri_manager/common/recure_storage/recure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../utils/data.dart';

final dioProvier = Provider((ref){
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);
  //예외처리 인터셉트
  dio.interceptors.add(
    CustomInterceptor(storage: storage)
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  //요청 보낼 때,
  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    print("[REQ] [${options.method}] ${options.uri}");

    //요청의 헤더에 엑세스토큰이 true인경우 실제 엑세스 토큰을 storage에서 가져옴
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken'); //키 삭제

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll(({
        'authorization': 'Bearer $token',
      }));

      if (options.headers['refreshToken'] == 'true') {
        options.headers.remove('refreshToken'); //키 삭제

        final token = await storage.read(key: REFRESH_TOKEN_KEY);

        options.headers.addAll(({
          'authorization': 'Bearer $token',
        }));
      }

      super.onRequest(options, handler);
    }

    //응답 받을 때
    @override
    void onResponse(Response response,
        ResponseInterceptorHandler handler) async {
      print("[RES] [${response.requestOptions.method}] ${response.requestOptions
          .uri}");
      super.onResponse(response, handler);
    }
    //에러 났을 때
    @override
    void onError(DioException err,
        ErrorInterceptorHandler handler) async {
      print("[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}");
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      //refreshToken이 없는 경우
      if (refreshToken == null) {
        return handler.reject(err);
      }

      final isStatus401 = err.response?.statusCode == 401;
      final isPathRefresh = err.requestOptions.path ==
          '/auth/token'; //토큰 재발급 과정에서의 에러인지 체크.(리프레시 토큰 자체의문제

      if (isStatus401 && !isPathRefresh) {
        //토큰재발급
        final dio = Dio();
        try {
          final resp = await dio.post('http://$ip/auth/token',
              options: Options(headers: {
                'authorization': 'Bearer $refreshToken',
              }));
          final accessToken = resp.data['accessToken'];

          final options = err.requestOptions;

          //토큰 변경후, 요청 재전송
          options.headers.addAll({'authorization': 'Bearer $accessToken'});
          await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
          final response = await dio.fetch(options);

          return handler.resolve(response);

        } on DioError catch (e) {
          return handler.reject(e);
        }
      }

      return handler.reject(err);
    }
  }
}
