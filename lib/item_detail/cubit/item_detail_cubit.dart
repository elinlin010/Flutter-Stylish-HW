import 'package:bloc/bloc.dart';

/// {@template item_detail_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class ItemDetailCubit extends Cubit<Order> {
  /// {@macro item_detail_cubit}
  ItemDetailCubit() : super(Order());

  /// Add 1 to the current state.
  void increment() => emit(state.copyWith(count: state.count + 1));

  /// Subtract 1 from the current state.
  void decrement() => emit(state.count == 0? state : state.copyWith(count: state.count - 1));

  void setSize(Size size) => emit(state.copyWith(size: size));
}


enum Size { DEFAULT, S, M, L }

class Order {
  final int count;
  final Size size;

  Order({this.count = 0, this.size = Size.DEFAULT});

  Order copyWith({int? count, Size? size}) => Order(
    count: count ?? this.count,
    size: size ?? this.size,
  );
}