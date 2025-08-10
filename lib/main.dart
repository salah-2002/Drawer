import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/counter_page.dart';
import 'pages/contacts_page.dart';
import 'pages/meteo_page.dart';
import 'pages/gallery_page.dart';

void main() {
  runApp(const DrawerDemoApp());
}

class DrawerDemoApp extends StatelessWidget {
  const DrawerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/counter': (_) => const CounterPage(),
        '/contacts': (_) => const ContactsPage(),
        '/meteo': (_) => const MeteoPage(),
        '/gallery': (_) => const GalleryPage(),
      },
    );
  }
}
