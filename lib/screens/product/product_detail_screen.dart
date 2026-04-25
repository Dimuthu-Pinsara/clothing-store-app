import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/common/bottom_nav_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  final List<Color> _productColors = [
    const Color(0xFFDBC126), // Yellow
    const Color(0xFF6CD4D3), // Cyan
    const Color(0xFF1A60D4), // Blue
    const Color(0xFFD61F5D), // Pink
  ];

  final List<String> _productSizes = ['XS', 'S', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductProvider>().getById(widget.productId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 700,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Product Title
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'RS.${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    // Generating a dummy old price based on current price for UI accuracy
                    'RS.${(product.price + 700).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Colors Section
              const Text(
                'colors',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  _productColors.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedColorIndex = index),
                    child: _ColorSwatch(
                      color: _productColors[index],
                      isSelected: _selectedColorIndex == index,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sizes Section
              const Text(
                'sizes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  _productSizes.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedSizeIndex = index),
                    child: _SizeBox(
                      text: _productSizes[index],
                      isSelected: _selectedSizeIndex == index,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Description
              Text(
                product
                    .description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add to Cart Button
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  context.read<CartProvider>().addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Reusable Bottom Nav
          const BottomNavBar(),
        ],
      ),
    );
  }
}

// Helper Widget for Color Selection
class _ColorSwatch extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _ColorSwatch({required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.black54, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Size Selection
class _SizeBox extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _SizeBox({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 35,
      margin: const EdgeInsets.only(right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.black : const Color(0xFFE0E0E0),
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}