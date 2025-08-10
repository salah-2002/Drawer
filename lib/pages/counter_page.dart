import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/counter'),
      appBar: AppBar(title: const Text('Compteur')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Valeur du compteur', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('$_count', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                FilledButton.tonal(
                  onPressed: () => setState(() => _count--),
                  child: const Text('−'),
                ),
                FilledButton(
                  onPressed: () => setState(() => _count++),
                  child: const Text('+'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
