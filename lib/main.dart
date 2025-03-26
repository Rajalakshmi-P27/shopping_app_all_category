import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'views/product_list_screen.dart';

void main() {
  runApp(
    BlocProvider<CartBloc>(
      create: (context) => CartBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListScreen(),
      ),
    ),
  );
}
