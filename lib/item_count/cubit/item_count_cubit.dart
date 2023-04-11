import 'package:bloc/bloc.dart';

/// {@template item_counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class ItemCounterCubit extends Cubit<int> {
  /// {@macro item_counter_cubit}
  ItemCounterCubit() : super(0);

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// Subtract 1 from the current state.
  void decrement() => emit(state == 0? state : state - 1);
}