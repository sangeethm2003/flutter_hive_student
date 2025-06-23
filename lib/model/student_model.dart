import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String mobile;

  @HiveField(4)
  String gender;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
  });
}
