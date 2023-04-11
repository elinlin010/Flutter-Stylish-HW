import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/item_count_cubit.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [ItemCounterCubit] state and notifies it in response to user input.
/// {@endtemplate}

import 'dart:io';

import 'package:flutter_week_1/product.dart';

import '../../myappbar.dart';


class ItemDetailView extends StatefulWidget {
  const ItemDetailView({super.key, required this.item});

  final Product item;

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

enum ProductSize { DEFAULT, S, M, L }

class _ItemDetailViewState extends State<ItemDetailView> {

  ProductSize get selectedSize => _selectedSize;
  var _selectedSize = ProductSize.DEFAULT;
  set selectedSize(ProductSize size) => setState(() => _selectedSize = size);

  // int get selectedCount => _selectedCount;
  // var _selectedCount = 1;
  // set selectedCount(int count) => setState(() =>_selectedCount = count);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
        child: Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: Platform.isIOS || Platform.isAndroid? 360 : 800,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Platform.isIOS || Platform.isAndroid?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _getItemViews(context, true)
                  )
                  : 
                  Row(children: _getItemViews(context, false)),
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

  List<Widget> _getItemViews(BuildContext context, bool isMobile) {
    if (isMobile) {
      return [
        Image(image: AssetImage(widget.item.imgUrl)),
        const SizedBox(height: 10),
        createDetailView(context),
      ];
    } else {
      return [
        Expanded(flex: 5, child: Image(image: AssetImage(widget.item.imgUrl))),
        const SizedBox(width: 10),
        Expanded(flex: 5, child: createDetailView(context)),
      ];
    }
  }

  Padding createDetailView(BuildContext context) {
    var item = widget.item;
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
                          children: _getColorPreview(),),
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(children: _getSizePreview(),),
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(children: _getCountPreview(),),
                      ),
                      const SizedBox(height: 16),
                      Material(
                        color: Colors.black87,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(0),
                          hoverColor: Colors.white24,
                          onTap: (){},
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              '請選擇尺寸',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          )
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("實品顏色以單品照為主\n棉 100%\n厚薄：薄\n彈性：無\n素材產地：日本\n加工產地：中國", style: TextStyle(fontWeight: FontWeight.w500),)
                    ],
                  ),
                );
  }

  List<Widget> _getSizePreview() {
    List<Widget> previews = <Widget>[];
    previews.add(const Text("尺寸"));
    previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
    previews.add(const SizedBox(width: 8));
    previews.add(createSizeBox(ProductSize.S));
    previews.add(const SizedBox(width: 8));
    previews.add(createSizeBox(ProductSize.M));
    previews.add(const SizedBox(width: 8));
    previews.add(createSizeBox(ProductSize.L));
    return previews;
  }

  GestureDetector createSizeBox(ProductSize size) {
    return GestureDetector(
      onTap: () => selectedSize = size,
      child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selectedSize == size? Colors.lime:Colors.blueGrey,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(size.name, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  List<Widget> _getColorPreview() {
    List<Widget> previews = <Widget>[];
    previews.add(const Text("顏色"));
    previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
    for (var c in widget.item.colors) {
      previews.add(const SizedBox(width: 8));
      previews.add(Container(width: 20, color: c));
      previews.add(const SizedBox(width: 8));
    }
    return previews;
  }
  List<Widget> _getCountPreview() {
    List<Widget> previews = <Widget>[];
    previews.add(const Text("數量"));
    previews.add(const VerticalDivider(thickness: 1, color: Colors.grey));
    previews.add(
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.read<ItemCounterCubit>().decrement(),
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
                  child: BlocBuilder<ItemCounterCubit, int>(
                    builder: (context, state) {
                      return TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.zero,
                        ),
                        controller: TextEditingController()..text = '$state',
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<ItemCounterCubit>().increment(),
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
}


// Scaffold(
//       appBar: AppBar(title: const Text('Counter')),
//       body: Center(
//         child: BlocBuilder<CounterCubit, int>(
//           builder: (context, state) {
//             return Text('$state', style: textTheme.displayMedium);
//           },
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             key: const Key('counterView_increment_floatingActionButton'),
//             child: const Icon(Icons.add),
//             onPressed: () => context.read<CounterCubit>().increment(),
//           ),
//           const SizedBox(height: 8),
//           FloatingActionButton(
//             key: const Key('counterView_decrement_floatingActionButton'),
//             child: const Icon(Icons.remove),
//             onPressed: () => context.read<CounterCubit>().decrement(),
//           ),
//         ],
//       ),
//     );