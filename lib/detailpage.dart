import 'package:flutter/material.dart';
import 'package:flutter_week_1/product.dart';

import 'myappbar.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required this.item});

  final Product item;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  var selectedSize = "";

  void setSelectedSize(String size) {
    setState(() => selectedSize = size);
  }

  @override
  Widget build(BuildContext context) {
    final Product item = widget.item;
    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 360,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage(item.imgUrl)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item.id,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "${item.fiat} ${item.price}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Divider(),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: _getColorPreview("顏色", item.colors),),
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(children: _getSizePreview("尺寸", selectedSize, setSelectedSize),),
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(children: _getCountPreview("數量"),),
                      ),
                    ],
                  ),
                ),
              ].map(
                (e) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: e,
                ),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _getColorPreview(String label, List<Color> colors) {
  List<Widget> previews = <Widget>[];
  previews.add(Text(label));
  previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
  for (var c in colors) {
    previews.add(const SizedBox(width: 8));
    previews.add(Container(width: 20, color: c));
    previews.add(const SizedBox(width: 8));
  }
  return previews;
}

List<Widget> _getSizePreview(String label, String selectedSize, Function onTap) {
  List<Widget> previews = <Widget>[];
  previews.add(Text(label));
  previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
  previews.add(const SizedBox(width: 8));
  previews.add(
    GestureDetector(
      onTap: () => onTap("S"),
      child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selectedSize == "S"? Colors.lime:Colors.blueGrey,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text("S", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    )
  );
  previews.add(const SizedBox(width: 8));
  previews.add(
    GestureDetector(
      onTap: () => onTap("M"),
      child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selectedSize == "M"? Colors.lime:Colors.blueGrey,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text("M", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    )
  );
  previews.add(const SizedBox(width: 8));
  previews.add(
    GestureDetector(
      onTap: () => onTap("L"),
      child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selectedSize == "L"? Colors.lime:Colors.blueGrey,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text("L", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    )
  );
  return previews;
}

List<Widget> _getCountPreview(String label) {
  List<Widget> previews = <Widget>[];
  previews.add(Text(label));
  previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));

    previews.add(const SizedBox(width: 8));
    //previews.add(Container(width: 20, color: c));
    previews.add(const SizedBox(width: 8));

  return previews;
}