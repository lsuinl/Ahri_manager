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
    // ref.listen<UserModelBase?>(userMeProvider,(previous,next ){
    //   if(previous != next){
    //     notifyListeners();
    //   }
    // });
  }
}