import 'package:equatable/equatable.dart';
import 'package:shopping_h/models/product_models.dart';

// EVENTS
abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);

  @override
  List<Object?> get props => [product];
}

class IncreaseQuantity extends CartEvent {
  final Product product;
  IncreaseQuantity(this.product);
}

class DecreaseQuantity extends CartEvent {
  final Product product;
  DecreaseQuantity(this.product);
}

class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;

  AddToCartEvent(this.product, this.quantity);

  @override
  List<Object?> get props => [product, quantity];
}
