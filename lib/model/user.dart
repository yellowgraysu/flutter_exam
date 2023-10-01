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
}

class Teacher extends User {
  const Teacher({
    required this.title,
    this.photoUrl,
    required super.id,
    required super.name,
  });

  final String title;
  final String? photoUrl;
}
