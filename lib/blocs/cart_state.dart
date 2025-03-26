import 'package:equatable/equatable.dart';
import 'package:shopping_h/models/product_models.dart';

class CartState extends Equatable {
  final Map<Product, int> cartItems;

  const CartState({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

class CartInitial extends CartState {
  CartInitial() : super(cartItems: {});
}

class CartLoaded extends CartState {
  const CartLoaded({required super.cartItems});
}

class CartUpdated extends CartState {
  const CartUpdated(Map<Product, int> cartItems) : super(cartItems: cartItems);
}
