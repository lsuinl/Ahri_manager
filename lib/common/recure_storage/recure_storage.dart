import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

//주요데이터 관리용
final secureStorageProvider = Provider<FlutterSecureStorage>((ref)=>FlutterSecureStorage());