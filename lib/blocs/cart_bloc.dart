import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_h/models/product_models.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final updatedCart = Map<Product, int>.from(state.cartItems);
      if (updatedCart.containsKey(event.product)) {
        updatedCart[event.product] = updatedCart[event.product]! + 1;
      } else {
        updatedCart[event.product] = 1;
      }
      emit(CartState(cartItems: updatedCart));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedCart = Map<Product, int>.from(state.cartItems);
      updatedCart.remove(event.product);
      emit(CartState(cartItems: updatedCart));
    });

    //  Handle Increase Quantity
    on<IncreaseQuantity>((event, emit) {
      final updatedCart = Map<Product, int>.from(state.cartItems);
      if (updatedCart.containsKey(event.product)) {
        updatedCart[event.product] = updatedCart[event.product]! + 1;
      }
      emit(CartState(cartItems: updatedCart));
    });

    // Handle Decrease Quantity
    on<DecreaseQuantity>((event, emit) {
      final updatedCart = Map<Product, int>.from(state.cartItems);
      if (updatedCart.containsKey(event.product) &&
          updatedCart[event.product]! > 1) {
        updatedCart[event.product] = updatedCart[event.product]! - 1;
      } else {
        updatedCart.remove(event.product); // Remove item if quantity reaches 0
      }
      emit(CartState(cartItems: updatedCart));
    });

    on<AddToCartEvent>((event, emit) {
      final updatedCart = Map<Product, int>.from(state.cartItems);
      if (updatedCart.containsKey(event.product)) {
        updatedCart[event.product] =
            updatedCart[event.product]! + event.quantity;
      } else {
        updatedCart[event.product] = event.quantity;
      }
      emit(CartUpdated(updatedCart));
    });
  }
}
