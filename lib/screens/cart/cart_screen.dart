import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    
    // Assuming a flat tax rate for demonstration, adjust according to your logic
    final double taxes = cart.items.isEmpty ? 0 : 500.00; 
    final double total = cart.totalPrice + taxes;

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
          'Your Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFF0F0F0),
            height: 1,
          ),
        ),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 16)))
          : Column(
              children: [
                // Header Row (ITEMS, DESCRIPTION, PRICE)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Text(
                          'ITEMS',
                          style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'DESCRIPTION',
                          style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1),
                        ),
                      ),
                      const Text(
                        'PRICE',
                        style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),

                // Cart Items List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cart.items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return _CartItemRow(item: item, cartProvider: cart);
                    },
                  ),
                ),

                // Order Summary & Checkout Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFF0F0F0)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SummaryRow(
                        title: 'Subtotal (${cart.items.length})',
                        value: 'RS.${cart.totalPrice.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 12),
                      const _SummaryRow(
                        title: 'Shipping total',
                        value: 'Free',
                      ),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        title: 'Taxes',
                        value: 'RS.${taxes.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'RS.${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () => context.push('/checkout'),
                          child: const Text(
                            'Proceed to checkout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // Extra padding for bottom safe area on modern phones
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final dynamic item; // Replace 'dynamic' with your actual CartItem model type
  final CartProvider cartProvider;

  const _CartItemRow({
    required this.item,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          // Note: using Image.asset assuming you are using local files based on previous data. 
          // Change back to Image.network if you are fetching from a URL.
          child: Image.asset(
            item.product.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        
        // Description and Quantity
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              
              // Custom Quantity Selector
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => cartProvider.decreaseQty(item.product.id),
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => cartProvider.increaseQty(item.product.id),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        
        // Price
        Text(
          'RS.${item.product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}