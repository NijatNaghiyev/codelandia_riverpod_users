import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';

final FutureProvider<List<UserModel>> usersData =
    FutureProvider<List<UserModel>>(
  (ref) async {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      final List<dynamic> users = response.data;
      return users.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  },
);

var userList = StateProvider<List<UserModel>>((ref) => []);
