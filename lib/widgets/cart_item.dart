import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_h/models/product_models.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartItem({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    double exchangeRate = 83.0; // 1 USD = 83 INR
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "₹${(product.price * exchangeRate).toStringAsFixed(2)}", // Convert USD to INR,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "₹${(product.discountedPrice * exchangeRate).toStringAsFixed(2)}", // Convert USD to INR
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${product.discountPercentage.toStringAsFixed(1)}% OFF",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //  Decrease Button
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartBloc>(
                                context,
                              ).add(DecreaseQuantity(product));
                            },
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 10),

                          //  Display Item Count
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),

                          // Increase Button
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<CartBloc>(
                                context,
                              ).add(IncreaseQuantity(product));
                            },
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
