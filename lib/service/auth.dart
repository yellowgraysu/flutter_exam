import 'dart:async';

import 'package:flutter_exam/service/database.dart';
import 'package:flutter_exam/model/user.dart';

final authService = _AuthService();

class _AuthService {
  _AuthService() : _userController = StreamController<User?>() {
    _userController.stream.listen((event) {});
  }

  final StreamController<User?> _userController;

  Stream<User?> get streamUserId => _userController.stream.asBroadcastStream();

  // 登陸，回傳為錯誤訊息，如果是null代表成功
  Future<String?> signIn(String id, String password) async {
    final result = await dbService.db.query(
      'accounts',
      columns: ['id', 'password', 'role'],
      where: "id = '$id'",
    );

    if (result.isEmpty) {
      return '帳號不存在';
    }
    if (result.first['password'] != password) {
      return '帳號或密碼錯誤';
    }

    if (result.first['role'] == 'teacher') {
      final teacher = await dbService.db.query(
        'teachers',
        columns: ['id', 'password', 'role'],
        where: "id = '$id'",
      );

      _userController.add(id);
    } else if (result.first['role'] == 'student') {
      _userController.add(id);
    }

    return null;
  }

  // 登出
  void logout() => _userController.add(null);
}
