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
    final users = ref.watch(usersData);
    final usersList = ref.watch(userList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Example'),
        ),
        body: Center(
          child: usersList.isEmpty
              ? const CircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () async => users.when(
                    data: (data) {
                      print('Refresh');
                      return ref
                          .read(userList.notifier)
                          .update((state) => state = data);
                    },
                    error: (error, stackTrace) => const SizedBox(),
                    loading: () => const CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: usersList.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(usersList[index].name),
                        subtitle: Text(usersList[index].email),
                      ),
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            users.when(
              data: (data) =>
                  ref.read(userList.notifier).update((state) => state = data),
              error: (error, stackTrace) => const SizedBox(),
              loading: () => const CircularProgressIndicator(),
            );
          },
          child: const Icon(Icons.data_exploration),
        ),
      ),
    );
  }
}
