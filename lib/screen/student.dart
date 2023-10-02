import 'package:flutter/material.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/screen/courses.dart';
import 'package:flutter_exam/service/auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StudentScreen extends HookWidget {
  const StudentScreen({super.key});

  static const String path = '/student';

  @override
  Widget build(BuildContext context) {
    final user = authService.user;

    if (user != null && user is Student) {
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
              children: [
                Text('id: ${user.id}'),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SafeArea(
                            child: Material(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.west,
                                            size: 24,
                                          ),
                                        ),
                                        const Text(
                                          '講師清單',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Expanded(child: CoursesScreen())
                                ],
                              ),
                            ),
                          );
                        },
                      ));
                    },
                    child: const Text('講師清單')),
              ],
            ),
          ),
        ),
      );
    }
    return const Material(child: Center(child: CircularProgressIndicator()));
  }
}
