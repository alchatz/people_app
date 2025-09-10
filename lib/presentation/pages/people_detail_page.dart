import 'package:flutter/material.dart';

import '../../domain/entities/person_entity.dart';


class PersonDetailPage extends StatelessWidget {
  final Person person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.first_name} ${person.last_name}'), // Use person's name in the AppBar
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Information Card
            _buildInfoCard(
              title: 'Contact Information',
              icon: Icons.person,
              children: [
                _buildInfoTile(icon: Icons.person_outline, title: 'Name', subtitle: '${person.first_name} ${person.last_name}'),
                _buildInfoTile(icon: Icons.email, title: 'Email', subtitle: person.email),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to create styled cards
  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  title,
                ),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  // Helper widget for a consistent information row (ListTile)
  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[800])),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}