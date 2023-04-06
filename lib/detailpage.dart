import 'dart:io';

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
  void setSelectedSize(String size) => setState(() => selectedSize = size);

var selectedCount = 1;
  void setSelectedCount(int count) => setState(() => selectedCount = count);

  @override
  Widget build(BuildContext context) {
    final Product item = widget.item;
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
        child: Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Platform.isIOS || Platform.isAndroid?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _getItemViews(item, context)
                  ),
                  // : Row(children: _getItemViews(item, context)),
                  Row(children: [
                    Text(
                      "細部說明",
                      style: TextStyle(
                        foreground: Paint()..shader =
                          const LinearGradient(
                            colors: <Color>[Color.fromARGB(255, 94, 14, 215), Color.fromARGB(255, 12, 230, 107)],
                          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)))
                    ),
                    const SizedBox(width: 10),
                    const Expanded(child: Divider(thickness: 1, color: Colors.grey,))
                  ],)
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
      ),
    );
  }


  List<Widget> _getItemViews(Product item, BuildContext context) {
    return [
      Image(image: AssetImage(item.imgUrl)),
      const SizedBox(width: 10),
      createDetailView(item, context),
    ];
  }

  Padding createDetailView(Product item, BuildContext context) {
    return Padding(
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
                        child: Row(children: _getCountPreview("數量", selectedCount, setSelectedCount),),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black54,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () { },
                        child: const Text(
                          '請選擇尺寸',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("實品顏色以單品照為主\n棉 100%\n厚薄：薄\n彈性：無\n素材產地：日本\n加工產地：中國", style: TextStyle(fontWeight: FontWeight.w500),)
                    ],
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

List<Widget> _getCountPreview(String label, int count, Function onTap) {
  List<Widget> previews = <Widget>[];
  previews.add(Text(label));
  previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
  previews.add(
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => onTap(count == 0? 0 : count - 1),
              child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text("-", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Flexible(
              child: SizedBox(
                height: 24,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero,
                  ),
                  controller: TextEditingController()..text = count.toString(),
                  //onSubmitted: (text) => onTap(int.tryParse(text) ?? count.toString()),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onTap(count + 1),
              child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text("+", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
        ),
          ],
        ),
      ),
    ));

  return previews;
}