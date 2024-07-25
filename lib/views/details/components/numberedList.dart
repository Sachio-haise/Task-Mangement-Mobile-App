import 'package:flutter/material.dart';

class NumberedList extends StatelessWidget {
  final List<String> items;

  const NumberedList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text('${index + 1}.', style: const TextStyle(fontSize: 18)),
          title: Text(items[index], style: const TextStyle(fontSize: 18)),
        );
      },
    );
  }
}
