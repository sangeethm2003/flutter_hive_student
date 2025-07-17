import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/student_model.dart';
import '../functions/hive_db.dart';
import 'screen2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = HiveDB();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final genderCtrl = TextEditingController();

  int getNextId() {
    final students = db.getStudents();
    if (students.isEmpty) return 1;
    return students.last.id + 1;
  }

  void clearFields() {
    nameCtrl.clear();
    emailCtrl.clear();
    mobileCtrl.clear();
    genderCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final studentBox = Hive.box<StudentModel>('studentBox');

    return Scaffold(
      appBar: AppBar(title: const Text('Hive Student details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: mobileCtrl,
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            TextField(
              controller: genderCtrl,
              decoration: const InputDecoration(labelText: 'Gender'),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
            ),
            
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isEmpty ||
                    emailCtrl.text.isEmpty ||
                    mobileCtrl.text.isEmpty ||
                    genderCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields.")),
                  );
                  return;
                }

                final student = StudentModel(
                  id: getNextId(),
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                  mobile: mobileCtrl.text,
                  gender: genderCtrl.text,
                  
                );
                db.addStudent(student);
                clearFields();
                setState(() {});
              },
              child: const Text('Add Student'),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentBox.listenable(),
                builder: (context, box, _) {
                  final students = box.values.toList();
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text(
                              '${student.email} | ${student.mobile} | ${student.gender}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Screen2(
                                  name: student.name,
                                  email: student.email,
                                  mobile: student.mobile,
                                  gender: student.gender,
                                  index: student.id,
                                ),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Color.fromARGB(255, 31, 102, 160)),
                                onPressed: () {
                                  nameCtrl.text = student.name;
                                  emailCtrl.text = student.email;
                                  mobileCtrl.text = student.mobile;
                                  genderCtrl.text = student.gender;

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Update Student'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: nameCtrl,
                                              decoration: const InputDecoration(labelText: 'Name'),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                                              ],
                                            ),
                                            TextField(
                                              controller: emailCtrl,
                                              decoration: const InputDecoration(labelText: 'Email'),
                                            ),
                                            TextField(
                                              controller: mobileCtrl,
                                              decoration: const InputDecoration(labelText: 'Mobile'),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(10),
                                              ],
                                            ),
                                            TextField(
                                              controller: genderCtrl,
                                              decoration: const InputDecoration(labelText: 'Gender'),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                                              ],
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              final updated = StudentModel(
                                                id: student.id,
                                                name: nameCtrl.text,
                                                email: emailCtrl.text,
                                                mobile: mobileCtrl.text,
                                                gender: genderCtrl.text,
                                                
                                              );
                                              db.updateStudent(updated);
                                              clearFields();
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Update'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 243, 57, 43)),
                                onPressed: () {
                                  db.deleteStudent(student.id);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
