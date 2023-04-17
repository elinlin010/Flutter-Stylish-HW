import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_1/models/campaign.dart';
import 'package:http/http.dart' as http;

import 'models/product.dart';
import 'bigcard.dart';
import 'item_detail/view/item_detail_page.dart';
import 'myappbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // const MyHomePage({super.key, required this.title});
  // final String title; //the valud provided by the parent.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Campaign>> campaigns;
  late Future<List<ProductList>> lists;

  @override
  void initState() {
    super.initState();
    campaigns = _fetchCampaignsfromWeb();
    lists = _fetchProductListsfromWeb();
  }

  @override
  Widget build(BuildContext context) {
    var campaignCards = <Widget>[];

    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          children: [
              FutureBuilder<List<Campaign>>(
                future: campaigns,
                builder: (context, fetchedCampaigns) {
                  if (fetchedCampaigns.hasData) {
                    for (Campaign campaign in fetchedCampaigns.data!) {
                      campaignCards.add(BigCard(campaignURL: campaign.pictureURL,));
                    }
                    return SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        children: [for (var campaign in campaignCards) campaign],
                      )
                    );
                  } else if (fetchedCampaigns.hasError) {
                    return Text('${fetchedCampaigns.error}');
                  }
    
                  // By default, show a loading spinner.
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
            ),
            FutureBuilder<List<ProductList>>(
              future: lists,
              builder: (context, fetchedLists) {
                if (fetchedLists.hasData) {
                  return Platform.isIOS || Platform.isAndroid ?
                    VerticalCatalogs(lists: fetchedLists.data!)
                    : HorizontalCatalogs(lists: fetchedLists.data!);
                } else if (fetchedLists.hasError) {
                  return Text('${fetchedLists.error}');
                }
  
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
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
            list.categoryName,
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
    List<Widget> allLists = <Widget>[];
    for (var list in lists) {
      allLists.add(
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: list.products.length + 1,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Text(
                    list.categoryName,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                } else {
                  return ItemCard(item: list.products[i - 1]);
                }
              }
            ),
          )
        )
      );
    }

    return Expanded(child: Row(children: allLists));
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
                SizedBox(
                  height: 120,
                  width: 80,
                  child: CachedNetworkImage(
                    imageUrl: item.mainImgUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
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
              // builder: (context) => ItemDetailPage(item: item),
              builder: (context) => ItemDetailPage(item: item),
            )
          );
        });
  }
}

// Future<List<AssetImage>> _fetchCampaigns() async {
//   return Future.value(<AssetImage>[
//     const AssetImage('assets/demo_image.jpeg'),
//     const AssetImage('assets/demo_image.jpeg'),
//     const AssetImage('assets/demo_image.jpeg'),
//     const AssetImage('assets/demo_image.jpeg'),
//     const AssetImage('assets/demo_image.jpeg'),
//   ]);
// }

Future<List<Campaign>> _fetchCampaignsfromWeb() async {
  try {
    final response = await http.get(Uri.parse('https://api.appworks-school.tw/api/1.0/marketing/campaigns'));
    return compute(_parseCampaigns, response);
  } catch (e) {
    if(e is SocketException) {
      //treat SocketException
      // ignore: avoid_print
      print("Socket exception: ${e.toString()}");
    }
    else if(e is TimeoutException) {
      //treat TimeoutException
      // ignore: avoid_print
      print("Timeout exception: ${e.toString()}");
    }
    else {
      // ignore: avoid_print
      print("Unhandled exception: ${e.toString()}");
    }
    return Future.value(<Campaign>[]);
  }

  //runs expensive functions in a background isolate and returns the result
  
}

List<Campaign> _parseCampaigns(http.Response response) {
  var campaignObjs = jsonDecode(response.body)['data'] as List;
  
  return campaignObjs.map(
    (campaignJson) => Campaign.fromJson(campaignJson)
  ).toList();
}

// Future<List<ProductList>> _fetchProductLists() async {
//   List<ProductList> allProductLists = <ProductList>[];
//   ProductList women = ProductList(categoryName: "女裝", products: _getProducts());
//   ProductList men = ProductList(categoryName: "男裝", products: _getProducts());
//   ProductList accessories = ProductList(categoryName: "配件", products: _getProducts());

//   allProductLists.add(women);
//   allProductLists.add(men);
//   allProductLists.add(accessories);

//   return Future.value(allProductLists);
// }

Future<List<ProductList>> _fetchProductListsfromWeb() async {
  try {
    final results = await Future.wait([_fetchWomenProducts(), _fetchMenProducts(), _fetchAccessoriesProducts()]);

    List<ProductList> allProductLists = <ProductList>[];
    allProductLists.add(results[0]);
    allProductLists.add(results[1]);
    allProductLists.add(results[2]);

    return allProductLists;
  } catch (e) {
    if(e is SocketException) {
      //treat SocketException
      // ignore: avoid_print
      print("Socket exception: ${e.toString()}");
    }
    else if(e is TimeoutException) {
      //treat TimeoutException
      // ignore: avoid_print
      print("Timeout exception: ${e.toString()}");
    }
    else {
      // ignore: avoid_print
      print("Unhandled exception: ${e.toString()}");
    }
    return Future.value(<ProductList>[]);
  }
}

Future<ProductList> _fetchWomenProducts() async {
  final response = await http.get(Uri.parse('https://api.appworks-school.tw/api/1.0/products/women'));

  //runs expensive functions in a background isolate and returns the result
  return compute(_parseProducts, {'name':'女裝', 'response':response});
}

Future<ProductList> _fetchMenProducts() async {
  final response = await http.get(Uri.parse('https://api.appworks-school.tw/api/1.0/products/men'));

  //runs expensive functions in a background isolate and returns the result
  return compute(_parseProducts, {'name':'男裝', 'response':response});
}

Future<ProductList> _fetchAccessoriesProducts() async {
  final response = await http.get(Uri.parse('https://api.appworks-school.tw/api/1.0/products/accessories'));

  //runs expensive functions in a background isolate and returns the result
  return compute(_parseProducts, {'name':'配件', 'response':response});
}

ProductList _parseProducts(Map<String, dynamic> map) {
  String category = map['name'];
  http.Response response = map['response'];

  var decodeJson = jsonDecode(response.body);
  var productObjs = decodeJson['data'] as List;
  var nextPage = decodeJson['next_paging'] as int?;
  
  return ProductList(
    categoryName: category,
    products: productObjs.map(
      (productJson) => Product.fromJson(productJson)
    ).toList(),
    nextPage: nextPage
  );
}
