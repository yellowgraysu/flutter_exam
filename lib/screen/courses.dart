import 'package:flutter/material.dart';
import 'package:flutter_exam/model/course.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/service/database.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TeacherWithCourse>>(
      future: _getTeachersWithCourses(),
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data != null) {
          return ListView(
            children: data.map((e) => TeacherItem(e)).toList(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<List<TeacherWithCourse>> _getTeachersWithCourses() async {
    final allCourses = await dbService.selectCourses();
    final teachers = await dbService.selectTeachers();

    return teachers.map((t) {
      final courses = allCourses.where((c) => c.teacherId == t.id).toList();
      return TeacherWithCourse(
        id: t.id,
        name: t.name,
        title: t.title,
        courses: courses,
      );
    }).toList();
  }
}

class TeacherItem extends HookWidget {
  const TeacherItem(this.teacher, {super.key});

  final TeacherWithCourse teacher;

  @override
  Widget build(BuildContext context) {
    final expanded = useState<bool>(false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black87),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 80,
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        teacher.title,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teacher.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      expanded.value = !expanded.value;
                    },
                    icon: Icon(
                      expanded.value ? Icons.remove : Icons.add,
                      color: expanded.value ? Colors.black87 : Colors.black,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            if (expanded.value)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.black54,
                      height: 4,
                    ),
                  ),
                  for (final course in teacher.courses)
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 30,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  course.name,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  course.time,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.chevron_right,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TeacherWithCourse extends Teacher {
  TeacherWithCourse({
    required this.courses,
    required super.title,
    required super.id,
    required super.name,
  });

  final List<Course> courses;
}
