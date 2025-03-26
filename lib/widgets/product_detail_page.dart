import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_h/blocs/cart_bloc.dart';
import 'package:shopping_h/blocs/cart_event.dart';
import 'package:shopping_h/models/product_models.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double exchangeRate = 83.0;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue.shade100, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30), // Overall Padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  child: Image.network(
                    widget.product.image,
                    width: screenWidth * 0.8, // 80% of screen width
                    height: 250, // Fixed height
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 16), // Spacing
              // Category
              Text(
                widget.product.category.toUpperCase(),
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),

              SizedBox(height: 10),

              // Product Title
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.050,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              // Description
              Text(
                widget.product.description,
                style: TextStyle(fontSize: screenWidth * 0.045),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 10),

              // Price Row
              Row(
                children: [
                  Text(
                    "₹${(widget.product.price * exchangeRate).toStringAsFixed(2)}", // Convert USD to INR
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "₹${(widget.product.discountedPrice * exchangeRate).toStringAsFixed(2)}", // Convert USD to INR
                    style: TextStyle(
                      fontSize: screenWidth * 0.050,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Discount
              Row(
                children: [
                  Text(
                    'Discount:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Text('${widget.product.discountPercentage}% OFF'),
                ],
              ),

              // Rating
              Row(
                children: [
                  Text(
                    'Rating:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Text('${widget.product.rating ?? 'N/A'} ⭐'),
                ],
              ),

              // Stock
              Row(
                children: [
                  Text('Stock:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Text('${widget.product.stock ?? 'Out of stock'}'),
                ],
              ),

              SizedBox(height: 20),

              // Quantity Selector
              Row(
                children: [
                  Text(
                    'Quantity:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Add to Cart Button
              ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(
                    AddToCartEvent(widget.product, quantity),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(247, 216, 41, 1),
                  fixedSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
}
