import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product.dart';
import '../cubit/item_count_cubit.dart';
import 'item_detail_view.dart';


/// {@template item_detail_page}
/// A [StatelessWidget] which is responsible for providing a
/// [ItemCounterCubit] instance to the [ItemDetailView].
/// {@endtemplate}
class ItemDetailPage extends StatelessWidget {
  /// {@macro item_detail_page}
  const ItemDetailPage({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemCounterCubit(),
      child: ItemDetailView(item: item),
    );
  }
}