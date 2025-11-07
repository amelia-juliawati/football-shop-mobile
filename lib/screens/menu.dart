import 'package:flutter/material.dart';
import 'package:turboa_mobile/widgets/left_drawer.dart';
import 'package:turboa_mobile/widgets/products_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final String nama = "Amelia Juliawati";
  final String npm = "2406414076";
  final String kelas = "A";

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_cart),
    ItemHomepage("My Products", Icons.inventory),
    ItemHomepage("Create Products", Icons.add),
  ];

  final List<Color> colors = [Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Turboa Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:  const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di Turboa Shop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Informasi(
                  title: 'Data Diri',
                  nama: nama,
                  npm: npm,
                  kelas: kelas,
                ),
                const SizedBox(height: 30),
                GridView.count(
                  padding: EdgeInsets.zero,
                  primary: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: colors.asMap().entries.map((entry) {
                    final index = entry.key;
                    final color = entry.value;
                    final item = items[index];
                    return ItemCard(item: item, color: color);
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Informasi extends StatelessWidget {
  final String title;
  final String nama;
  final String npm;
  final String kelas;

  const Informasi({
    super.key,
    required this.title,
    required this.nama,
    required this.npm,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 80,
              color: Color(0xFF144686),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF144686),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Nama: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: nama),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'NPM: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: npm),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Kelas: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: kelas),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  ItemHomepage(this.name, this.icon);
}