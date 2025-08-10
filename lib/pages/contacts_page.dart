import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'Alice', 'phone': '+212 600 000 001'},
      {'name': 'Bob',   'phone': '+212 600 000 002'},
      {'name': 'Chloe', 'phone': '+212 600 000 003'},
      {'name': 'David', 'phone': '+212 600 000 004'},
      {'name': 'Emma',  'phone': '+212 600 000 005'},
    ];

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/contacts'),
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final c = contacts[i];
          return ListTile(
            leading: CircleAvatar(child: Text(c['name']![0])),
            title: Text(c['name']!),
            subtitle: Text(c['phone']!),
            trailing: const Icon(Icons.call),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Appeler ${c['name']} (${c['phone']})')),
              );
            },
          );
        },
      ),
    );
  }
}
