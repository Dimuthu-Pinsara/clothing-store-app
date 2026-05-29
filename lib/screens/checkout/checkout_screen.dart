import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // 1. Added controllers for all your UI fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController(); // Added for the DB requirement
  
  String _selectedPayment = 'card'; // 'card', 'gpay', 'paypal'

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitOrder() async {
    final cartProvider = context.read<CartProvider>();
    
    // Validate inputs
    if (_addressController.text.isEmpty || 
        _cityController.text.isEmpty || 
        _phoneController.text.isEmpty ||
        _firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final orderProvider = context.read<OrderProvider>();

    if (authProvider.user == null) return;

    // Combine the address fields for Firestore
    final fullAddress = '${_addressController.text}, ${_cityController.text}, ${_zipController.text}';

    // Send to Firestore
    final error = await orderProvider.placeOrder(
      userId: authProvider.user!.uid, 
      totalAmount: cartProvider.totalAmount,
      cartItems: cartProvider.items.values.toList(),
      deliveryAddress: fullAddress,
      phone: _phoneController.text,
    );

    // Handle success or failure
    if (error == null) {
      cartProvider.clearCart();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully!')),
        );
        context.go('/home'); 
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 2. Fetch live cart data and loading state
    final cart = context.watch<CartProvider>();
    final isLoading = context.watch<OrderProvider>().isLoading;
    final cartItems = cart.items.values.toList();
    
    final subtotal = cart.totalAmount;
    final taxes = 0.0; // Adjust if you add tax calculation logic
    final total = subtotal + taxes;

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
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFF0F0F0), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SHIPPING ADDRESS SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: 'SHIPPING ADDRESS', showChevron: true),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('Last Name', 'Perera', _lastNameController)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('First Name', 'Kasun', _firstNameController)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInputField('Street Address', 'e.g. Galle Rd, Baddegama', _addressController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('City', 'e.g. Galle', _cityController)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('ZIP code', '80200', _zipController, type: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Added Phone field to match your backend logic
                  _buildInputField('Phone Number', '07X XXX XXXX', _phoneController, type: TextInputType.phone),
                ],
              ),
            ),
            
            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // DELIVERY SECTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Text(
                    'DELIVERY',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Free', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
                        SizedBox(height: 2),
                        Text('Standard | 3-4 days', style: TextStyle(fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.black54),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // PAYMENT SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: 'PAYMENT', showChevron: true),
                  const SizedBox(height: 16),
                  _buildPaymentCard(
                    id: 'card',
                    icon: Icons.credit_card,
                    title: 'Credit / Debit Card',
                    subtitle: 'Visa ending in 4242',
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentCard(
                    id: 'gpay',
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Google Pay',
                    subtitle: 'Secure checkout with FaceID',
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentCard(
                    id: 'paypal',
                    icon: Icons.language, 
                    title: 'Pay Pal',
                    subtitle: 'Redirect to external wallet',
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // ORDER SUMMARY SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(title: 'ORDER SUMMARY', showChevron: false),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FF), 
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                            const SizedBox(height: 4),
                            // 3. Dynamic item count
                            Text('Selected ${cart.items.length} items', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                          ],
                        ),
                        // 4. Dynamic Overlapping Avatars (Max 3 to prevent overflow)
                        SizedBox(
                          width: 80,
                          height: 40,
                          child: Stack(
                            children: List.generate(
                              cartItems.length > 3 ? 3 : cartItems.length,
                              (index) {
                                final productImg = cartItems[index].product.image;
                                // Handle web URL vs local asset
                                final ImageProvider imgProvider = productImg.startsWith('http') 
                                    ? NetworkImage(productImg) 
                                    : AssetImage(productImg) as ImageProvider;

                                return Positioned(
                                  right: index * 20.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFE8F0FF), width: 2),
                                    ),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: imgProvider,
                                    ),
                                  ),
                                );
                              },
                            ).reversed.toList(), // Reverse to stack correctly
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // TOTALS SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 5. Dynamic Totals
                  _SummaryRow(title: 'Subtotal (${cart.items.length})', value: 'RS.${subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 12),
                  const _SummaryRow(title: 'Shipping total', value: 'Free'),
                  const SizedBox(height: 12),
                  _SummaryRow(title: 'Taxes', value: 'RS.${taxes.toStringAsFixed(2)}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('RS.${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // PLACE ORDER BUTTON
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
                      // 6. Connected logic
                      onPressed: isLoading ? null : _submitOrder,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Place order',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Converted to actual TextField so users can type in it
  Widget _buildInputField(String label, String hint, TextEditingController controller, {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller,
            keyboardType: type,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedPayment == id;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF4F7FF) : const Color(0xFFF5F5F5),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A7DFF) : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE5EFFF) : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: isSelected ? const Color(0xFF4A7DFF) : Colors.black87, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF4A7DFF), size: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool showChevron;

  const _SectionHeader({required this.title, required this.showChevron});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        if (showChevron) const Icon(Icons.expand_more, color: Colors.black54, size: 20),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}