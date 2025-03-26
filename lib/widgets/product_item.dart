import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_h/blocs/cart_bloc.dart';
import 'package:shopping_h/blocs/cart_event.dart';
import 'package:shopping_h/models/product_models.dart';

import 'package:shopping_h/widgets/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double exchangeRate = 83.0; // 1 USD = 83 INR
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: SizedBox(
        height: screenHeight * 0.35,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: screenHeight * 0.50,
                      ),
                    ),
                    // Positioned Add Button
                    Positioned(
                      bottom: 2,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(
                            context,
                          ).add(AddToCart(product));
                          _showPopup(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.red,
                                size: screenWidth * 0.04,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
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
                        color: Colors.black,
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
                          "₹${(product.discountedPrice * exchangeRate).toStringAsFixed(2)}", // Convert USD to INR,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Popup to show item added message
  void _showPopup(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Item added to cart"),
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
