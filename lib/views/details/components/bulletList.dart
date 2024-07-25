import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("• ", style: TextStyle(fontSize: 14)),
              Expanded(
                child: Text(item, style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
