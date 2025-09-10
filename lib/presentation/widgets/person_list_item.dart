import 'package:flutter/material.dart';
import '../../domain/entities/person_entity.dart';

class PersonListItem extends StatelessWidget {
  final Person person;
  final VoidCallback onTap;

  const PersonListItem({
    super.key,
    required this.person,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey[700],
            child: Image.network(person.avatar)
          ),
          title: Text(
            '${person.first_name} ${person.last_name}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}

