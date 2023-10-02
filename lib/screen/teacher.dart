import 'package:flutter/material.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/service/auth.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  static const String path = '/teacher';

  @override
  Widget build(BuildContext context) {
    final user = authService.user;

    if (user != null && user is Teacher) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            actions: [
              TextButton(
                onPressed: () => authService.logout(),
                child: const Text(
                  'log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id: ${user.id}'),
                Text('Title: ${user.title}'),
                Text('Photo url: ${user.photoUrl}'),
              ],
            ),
          ),
        ),
      );
    }
    return const Material(child: Center(child: CircularProgressIndicator()));
  }
}
