import 'package:flutter_exam/model/course.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:sqflite_common/sqflite.dart';
import 'package:path/path.dart' as p;

final dbService = _MySqliteDBService();

class _MySqliteDBService {
  late final Database db;

  Future init({reset = true}) async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'aaa.sqlite3');

    if (reset) {
      // Delete the database
      await deleteDatabase(path);
    }

    // Load test data
    db = await openDatabase(path);
    for (final query in initQueries) {
      db.execute(query);
    }
  }

  Future<Teacher> selectTeacherById(String id) async {
    final result = await db.rawQuery("SELECT * FROM teachers WHERE id = '$id'");
    return Teacher.fromMap(result.first);
  }

  Future<Student> selectStudentById(String id) async {
    final result = await db.rawQuery("SELECT * FROM students WHERE id = '$id'");
    return Student.fromMap(result.first);
  }

  // 課程列表 API (Read)
  Future<List<Course>> selectCourses() async {
    final result = await db.rawQuery('SELECT * FROM courses');
    return result.map((e) => Course.fromMap(e)).toList();
  }

  // 授課講師列表 API (Read)
  Future<List<Teacher>> selectTeachers() async {
    final result = await db.rawQuery('SELECT * FROM teachers');
    return result.map((e) => Teacher.fromMap(e)).toList();
  }

  // 授課講師所開課程列表 API (Read)
  Future selectTeacherCourses(String teacherId) async {
    final result = await db
        .rawQuery("SELECT * FROM courses WHERE teacher_id = '$teacherId'");
    return result.map((e) => Course.fromMap(e)).toList();
  }

  // 建立新講師 API (Create)
  Future createTeacher({
    required String id,
    required String password,
    required String name,
    required String title,
    String? photoUrl,
  }) async {
    await db.rawInsert(
        "INSERT INTO accounts (id, password) VALUES('$id', '$password')");
    await db.rawInsert(
        "INSERT INTO accounts (id, name,title,photo_url) VALUES('$id', '$name', '$title', '$photoUrl')");
  }

  // 建立新課程 API (Create)
  Future createCourse({
    required String id,
    required String name,
    required String time,
    required String teacherId,
  }) async {
    await db.rawInsert(
        "INSERT INTO courses (id, name, time, teacher_id) VALUES('$id','$name', '$time', '$teacherId')");
  }

  // 更新課程內容 API (Update)
  Future updateCourse({
    required Course course,
  }) async {
    await db.rawUpdate(
        'UPDATE courses SET name = ?, time = ?, teacher_id = ? WHERE id = ?',
        [course.name, course.time, course.teacherId, course.id]);
  }

  // 刪除課程 API (Delete)
  Future deleteCourse(String courseId) async {
    await db.delete('courses', where: "id = '$courseId'");
  }
}

const initQueries = [
  "CREATE TABLE accounts(id TEXT PRIMARY KEY,password TEXT, role TEXT)",
  "CREATE TABLE teachers (id TEXT PRIMARY KEY,name TEXT,title TEXT,photo_url TEXT);",
  "CREATE TABLE students (id TEXT PRIMARY KEY,name TEXT);",
  "CREATE TABLE courses (id TEXT PRIMARY KEY,name TEXT,time TEXT,teacher_id TEXT);",
  "CREATE TABLE student_picks (id TEXT PRIMARY KEY,student_id TEXT,course_id TEXT);",
  "INSERT INTO accounts (id, password, role) VALUES('teacher001', 'abcd123', 'teacher');",
  "INSERT INTO accounts (id, password, role) VALUES('teacher002', 'abcd123', 'teacher');",
  "INSERT INTO accounts (id, password, role) VALUES('teacher003', 'abcd123', 'teacher');",
  "INSERT INTO accounts (id, password, role) VALUES('teacher004', 'abcd123', 'teacher');",
  "INSERT INTO accounts (id, password, role) VALUES('teacher005', 'abcd123', 'teacher');",
  "INSERT INTO accounts (id, password, role) VALUES('student001', '000000', 'student');",
  "INSERT INTO accounts (id, password, role) VALUES('student002', '000000', 'student');",
  "INSERT INTO accounts (id, password, role) VALUES('student003', '000000', 'student');",
  "INSERT INTO teachers (id, name, title, photo_url) VALUES('teacher001','Albert Flores', 'Demonstrator','');",
  "INSERT INTO teachers (id, name, title, photo_url) VALUES('teacher002','Floyd Miles', 'Lecturer', '');",
  "INSERT INTO teachers (id, name, title, photo_url) VALUES('teacher003','Savannah Nguyen', 'Senior Lecturer', '');",
  "INSERT INTO teachers (id, name, title, photo_url) VALUES('teacher004','Jenny Wilson', 'Professor', '');",
  "INSERT INTO teachers (id, name, title, photo_url) VALUES('teacher005','Floyd Miles', 'Professor', '');",
  "INSERT INTO students (id, name) VALUES('student001','John');",
  "INSERT INTO students (id, name) VALUES('student002','Albert');",
  "INSERT INTO students (id, name) VALUES('student003','Jerry');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course001','基礎程式設計','每周二, 10:00-12:00', 'teacher001');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course002','人工智慧總整與實作', '每週四, 14:00-16:00', 'teacher001');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course003','訊號與系統', '每週五, 10:00-12:00', 'teacher001');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course004','課程A', '每週三, 08:00-10:00', 'teacher002');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course005','課程B', '每週四, 08:00-10:00', 'teacher002');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course006','課程C', '每週一, 14:00-16:00', 'teacher003');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course007','課程D', '每週五, 15:00-17:00', 'teacher003');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course008','課程E', '每週二, 09:00-12:00', 'teacher004');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course009','課程F', '每週一, 08:00-10:00', 'teacher005');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course010','課程G', '每週一, 10:00-12:00', 'teacher005');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course011','課程H', '每週一, 13:00-15:00', 'teacher005');",
  "INSERT INTO courses (id, name, time, teacher_id) VALUES('course012','課程I', '每週四, 13:00-15:00', 'teacher005');"
];
