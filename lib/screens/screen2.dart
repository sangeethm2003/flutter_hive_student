import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String name;
  final String email;
  final String mobile;
  final String gender;
  final int index;

  const Screen2({
    super.key,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 255, 233),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color.fromARGB(255, 233, 197, 197),
                  child: Icon(Icons.person, size: 60, color: Colors.teal),
                ),
                const SizedBox(height: 25),

              
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        infoBox(Icons.person, 'Name', name),
                        const SizedBox(height: 16),
                        infoBox(Icons.email, 'Email', email),
                        const SizedBox(height: 16),
                        infoBox(Icons.phone, 'Mobile', mobile),
                        const SizedBox(height: 16),
                        infoBox(Icons.person_outline, 'Gender', gender),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 172, 227, 223),
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoBox(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 125, 129, 129), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 212, 247, 244), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 14, color: Colors.black54)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
