import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';

/// Fetch data from API
Future<List<UserModel>> fetchData() async {
  final response =
      await Dio().get('https://jsonplaceholder.typicode.com/users');
  try {
    if (response.statusCode == 200) {
      final List users = response.data;
      return users.map((json) => UserModel.fromJson(json)).toList();
    }
  } catch (e) {
    throw Exception('Failed to load users');
  }
  return [];
}

/// StateProvider for users list
var userList = StateProvider<List<UserModel>>(
  (ref) => [],
);
