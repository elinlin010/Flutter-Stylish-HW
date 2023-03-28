import 'package:flutter/material.dart';
import 'package:flutter_week_1/Product.dart';

import 'myappbar.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required this.item});

  final Product item;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  @override
  Widget build(BuildContext context) {
    final Product item = widget.item;
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [SafeArea(child: Text(item.name))],
      ),
    );
  }
}
