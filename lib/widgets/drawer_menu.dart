import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  Widget _item(BuildContext ctx, {
    required String label,
    required IconData icon,
    required String route,
  }) {
    final selected = currentRoute == route;
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      onTap: () {
        if (selected) {
          Navigator.pop(ctx); // just close drawer
        } else {
          Navigator.pushReplacementNamed(ctx, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu, size: 40),
                  SizedBox(height: 12),
                  Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Naviguez entre les pages'),
                ],
              ),
            ),
            _item(context, label: 'Accueil',   icon: Icons.home,  route: '/'),
            _item(context, label: 'Compteur',  icon: Icons.exposure, route: '/counter'),
            _item(context, label: 'Contacts',  icon: Icons.contacts, route: '/contacts'),
            _item(context, label: 'Météo',     icon: Icons.cloud, route: '/meteo'),
            _item(context, label: 'Galerie',   icon: Icons.photo_library, route: '/gallery'),
          ],
        ),
      ),
    );
  }
}
