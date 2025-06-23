import 'package:hive/hive.dart';
import '../model/student_model.dart';

class HiveDB {
  final Box<StudentModel> studentBox = Hive.box<StudentModel>('studentBox');

  void addStudent(StudentModel student) {
    studentBox.put(student.id, student);
  }

  
  List<StudentModel> getStudents() {
    return studentBox.values.toList();
  }


  void updateStudent(StudentModel student) {
    studentBox.put(student.id, student);
  }


  void deleteStudent(int id) {
    studentBox.delete(id);
  }
}
