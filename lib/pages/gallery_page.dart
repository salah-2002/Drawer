import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // IDs Picsum arbitraires
    final ids = List<int>.generate(18, (i) => 10 + i); // 10..27

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/gallery'),
      appBar: AppBar(title: const Text('Galerie')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: ids.length,
        itemBuilder: (context, i) {
          final url = 'https://picsum.photos/id/${ids[i]}/400/600';
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: InteractiveViewer(
                    child: Image.network(url, fit: BoxFit.contain),
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (c, w, progress) {
                  if (progress == null) return w;
                  return const ColoredBox(
                    color: Color(0x11000000),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          );
        },
      ),
    );
  }
}
