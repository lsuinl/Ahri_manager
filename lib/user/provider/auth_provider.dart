import 'package:ahri_manager/screen/home.dart';
import 'package:ahri_manager/user/provider/user_me_provider.dart';
import 'package:ahri_manager/user/screen/loading_screen.dart';
import 'package:ahri_manager/user/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ahri_manager/user/model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref){
  return AuthProvider(ref:ref);
});

class AuthProvider extends ChangeNotifier{
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
     ref.listen<UserModelBase?>(userMeProvider,(previous,next ){
       if(previous != next){
         notifyListeners();
       }
     });
  }

List<GoRoute> get routes =>[
   GoRoute(path:'/',
       name: HomeScreen.routeName,
       builder:(_,__)=> HomeScreen(),
   ),
  GoRoute(path:'/loading',
    name: LoadingScreen.routeName,
    builder:(_,__)=> LoadingScreen(),
  ),
  GoRoute(path:'/login',
    name: LoginScreen.routeName,
    builder:(_,__)=> LoginScreen(),
  ),
];

String? redirectLogic(GoRouterState state){
  final UserModelBase? user = ref.read(userMeProvider);

  final logginIn = state.uri =='/login';

  //유저정보가 있음 => 그대로 두고
  //유저정보가 없는데 로그인이 아니면 => 로그인으로 이동
  if(user == null){
    return logginIn ? null:'/login';
  }


  //사용자 정보가 있고 로그인 or 현재가 로딩이면 => 홈으로
  //사용자 정보가 있고  위 두가지가 아니면 -> 하던대로 이동
  if(user is UserModel){
    return logginIn || state.path == '/splash'? '/':null;
  }

  //UserModelError
  if(user is UserModelError){
    return !logginIn ? '/login':null;
  }

  return null; //원래 가던곳으로 이동
}
}