class User {
  const User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}

class Student extends User {
  const Student({
    required super.id,
    required super.name,
  });

  factory Student.fromMap(Map<String, Object?> map) => Student(
        id: map['id'].toString(),
        name: map['name'].toString(),
      );
}

class Teacher extends User {
  const Teacher({
    required this.title,
    this.photoUrl,
    required super.id,
    required super.name,
  });

  factory Teacher.fromMap(Map<String, Object?> map) => Teacher(
        id: map['id'].toString(),
        name: map['name'].toString(),
        title: map['title'].toString(),
        photoUrl: map['photo_url']?.toString(),
      );

  final String title;
  final String? photoUrl;
}
