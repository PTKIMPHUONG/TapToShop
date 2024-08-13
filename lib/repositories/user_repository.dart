import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:collection/collection.dart';

class UserRepository {
  Future<List<User>> _loadUsers() async {
    final data = await rootBundle.loadString('assets/json/users.json');
    final jsonResult = json.decode(data) as List;
    return jsonResult.map((e) => User.fromJson(e)).toList();
  }

  Future<User?> getUserByEmail(String email) async {
    final users = await _loadUsers();
    return users.firstWhereOrNull((user) => user.email == email);
  }

  Future<User?> getUserById(String userId) async {
    final users = await _loadUsers();
    return users.firstWhereOrNull((user) => user.userId == userId);
  }

  Future<void> saveUser(User user) async {
    final users = await _loadUsers();
    users.add(user);
  }
}
