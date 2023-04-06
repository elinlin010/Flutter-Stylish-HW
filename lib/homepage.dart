import 'dart:io';

import 'package:flutter/material.dart';

import 'product.dart';
import 'bigcard.dart';
import 'detailpage.dart';
import 'myappbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // const MyHomePage({super.key, required this.title});
  // final String title; //the valud provided by the parent.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var campaignImages = _getCampaigns();
  var lists = _getProductLists();

  @override
  Widget build(BuildContext context) {
    var campaigns = <Widget>[];

    for (var image in campaignImages) {
      campaigns.add(BigCard(campaign: image,));
    }

    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [for (var campaign in campaigns) campaign],
            ),
          ),
          Platform.isIOS || Platform.isAndroid
              ? VerticalCatalogs(lists: lists)
              : HorizontalCatalogs(lists: lists),
        ],
      ),
    );
  }
}

class VerticalCatalogs extends StatelessWidget {
  const VerticalCatalogs({
    super.key,
    required this.lists,
  });

  final List<ProductList> lists;

  @override
  Widget build(BuildContext context) {
    List<Widget> allLists = <Widget>[];

    for (var list in lists) {
      for (var i = 0; i <= list.products.length; i++) {
        if (i == 0) {
          allLists.add(Center(
              child: Text(
            list.typeName,
            style: Theme.of(context).textTheme.titleMedium,
          )));
        } else {
          allLists.add(ItemCard(item: list.products[i - 1]));
        }
      }
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
            shrinkWrap: true,
            // shrinkWrap: true,
            // Let the ListView know how many items it needs to build.
            itemCount: allLists.length,
            // Provide a builder function. This is where the magic happens.
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
              return allLists[index];
            }),
      ),
    );
  }
}

class HorizontalCatalogs extends StatelessWidget {
  const HorizontalCatalogs({
    super.key,
    required this.lists,
  });

  final List<ProductList> lists;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                  // shrinkWrap: true,
                  // shrinkWrap: true,
                  // Let the ListView know how many items it needs to build.
                  itemCount: lists[0].products.length + 1,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, i) {
                    var list = lists[0];
                    if (i == 0) {
                      return Text(
                        list.typeName,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    } else {
                      return ItemCard(item: list.products[i - 1]);
                    }
                  }),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                  // shrinkWrap: true,
                  // shrinkWrap: true,
                  // Let the ListView know how many items it needs to build.
                  itemCount: lists[1].products.length + 1,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, i) {
                    var list = lists[1];
                    if (i == 0) {
                      return Text(
                        list.typeName,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    } else {
                      return ItemCard(item: list.products[i - 1]);
                    }
                  }),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                  // shrinkWrap: true,
                  // Let the ListView know how many items it needs to build.
                  itemCount: lists[2].products.length + 1,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, i) {
                    var list = lists[2];
                    if (i == 0) {
                      return Text(
                        list.typeName,
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    } else {
                      return ItemCard(item: list.products[i - 1]);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.black, width: 1),
            ),
            child: Row(
              children: [
                Container(
                    height: 120,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: AssetImage(item.imgUrl), fit: BoxFit.cover),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${item.fiat} ${item.price}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                ))
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemDetailPage(item: item),
            )
          );
        });
  }
}

class ProductList {
  const ProductList({required this.typeName, required this.products});

  final String typeName;
  final List<Product> products;
}

List<AssetImage> _getCampaigns() {
  return <AssetImage>[
    const AssetImage('assets/demo_image.jpeg'),
    const AssetImage('assets/demo_image.jpeg'),
    const AssetImage('assets/demo_image.jpeg'),
    const AssetImage('assets/demo_image.jpeg'),
    const AssetImage('assets/demo_image.jpeg'),
  ];
}

List<ProductList> _getProductLists() {
  List<ProductList> allProductLists = <ProductList>[];
  ProductList women = ProductList(typeName: "女裝", products: _getProducts());
  ProductList men = ProductList(typeName: "男裝", products: _getProducts());
  ProductList accessories =
      ProductList(typeName: "配件", products: _getProducts());

  allProductLists.add(women);
  allProductLists.add(men);
  allProductLists.add(accessories);

  return allProductLists;
}

List<Product> _getProducts() {
  List<Product> products = List<Product>.generate(
      8,
      (i) => const Product(
          imgUrl: "assets/demo_image.jpeg",
          name: "UNIQLO 特級極輕羽絨外套",
          id: "2023032101",
          price: 323,
          fiat: "NT\$",
          colors: [Colors.green, Colors.black]));

  return products;
}