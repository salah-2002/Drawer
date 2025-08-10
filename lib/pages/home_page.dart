import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/'),
      appBar: AppBar(title: const Text('Accueil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home, size: 72),
              const SizedBox(height: 16),
              Text(
                'Bienvenue !\nCette application montre un Drawer pour accéder à plusieurs pages :\n'
                '• Compteur\n• Contacts\n• Météo\n• Galerie',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
