class Course {
  Course({
    required this.id,
    required this.name,
    required this.time,
    required this.teacherId,
  });

  final String id;
  final String name;
  final String time;
  final String teacherId;

  factory Course.fromMap(Map<String, Object?> map) => Course(
        id: map['id'].toString(),
        name: map['name'].toString(),
        time: map['time'].toString(),
        teacherId: map['teacher_id'].toString(),
      );
}
