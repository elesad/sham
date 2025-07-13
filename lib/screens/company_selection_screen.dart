import 'package:flutter/material.dart';

class CompanySelectionScreen extends StatelessWidget {
  const CompanySelectionScreen({super.key});

  final List<Map<String, String>> companies = const [
    {'name': 'شركة الشام للنقل', 'logo': ''},
    {'name': 'شركة الأمانة', 'logo': ''},
    {'name': 'شركة الاتحاد', 'logo': ''},
    {'name': 'شركة بردى', 'logo': ''},
    {'name': 'شركة الياسمين', 'logo': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار الشركة'),
        backgroundColor: const Color(0xFF127C8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: companies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final company = companies[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF10B981),
                  child: const Icon(Icons.directions_bus, color: Colors.white),
                ),
                title: Text(company['name']!),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7C2D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('اختيار'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم اختيار ${company['name']}')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 
