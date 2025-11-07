import 'package:flutter/material.dart';
import 'package:turboa_mobile/screens/productlist_form.dart';
import 'package:turboa_mobile/screens/menu.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final Color color;

  const ItemCard({super.key, required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}")),
            );
          if (item.name == "Create Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}