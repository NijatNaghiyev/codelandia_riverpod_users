import 'package:codelandia_riverpod_users/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/user_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final usersList = ref.watch(userList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Example'),
        ),
        body: usersList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  final UserModel user = usersList[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchData().then(
              (value) => ref.read(userList.notifier).update(
                    (state) => state = value,
                  ),
            );
          },
          child: const Icon(Icons.data_exploration),
        ),
      ),
    );
  }
}
