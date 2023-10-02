// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_exam/service/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/v4.dart';

void main() {
  test('Course API test', () async {
    final id = const UuidV4().toString();
    const name = '課程X';
    const time = '星期三 19:00-21:00';
    const teacherId = 'teacher001';

    await dbService.init();

    /// 測試 1: 隨機 course id 不會存在資料庫中
    final test1Courses = await dbService.selectCourses();
    test1Courses.where((element) => false);
    final test1MatchedCourses = test1Courses.where((c) => c.id == id);
    expect(test1MatchedCourses.length, 0);

    /// 測試 2: 新增的 course 可以被搜尋的到
    await dbService.createCourse(
        id: id, name: name, time: time, teacherId: teacherId);
    final test2Courses = await dbService.selectCourses();
    final test2MatchedCourses = test2Courses.where((c) => c.id == id);
    expect(test2MatchedCourses.length, 1);

    /// 測試 3: 刪除本來搜尋的到 course，將不再存在資料庫
    await dbService.deleteCourse(id);
    final test3Courses = await dbService.selectCourses();
    final test3MatchedCourses = test3Courses.where((c) => c.id == id);
    expect(test3MatchedCourses.length, 0);
  });
}
