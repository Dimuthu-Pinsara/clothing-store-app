import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = 'card'; // 'card', 'gpay', 'paypal'

  @override
  Widget build(BuildContext context) {
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
                  _SectionHeader(title: 'SHIPPING ADDRESS', showChevron: true),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('Last Name', 'Meleena')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('First Name', 'Karunarathna')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInputField('Street Address', 'De Saram Rd, Dehiwala-Mount Lavinia'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('City', 'Dehiwala')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('ZIP code', 'Pinsara')),
                    ],
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1, color: Color(0xFFF0F0F0)),

            // DELIVERY SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'DELIVERY',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 40),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Free', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
                        SizedBox(height: 2),
                        Text('Standard | 3-4 days', style: TextStyle(fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.black54),
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
                  _SectionHeader(title: 'PAYMENT', showChevron: true),
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
                    icon: Icons.language, // Using globe icon as approximation
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
                  _SectionHeader(title: 'ORDER SUMMARY', showChevron: false),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FF), // Light blue background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                            SizedBox(height: 4),
                            Text('Selected 2 items', style: TextStyle(fontSize: 13, color: Colors.black87)),
                          ],
                        ),
                        // Overlapping Avatars
                        SizedBox(
                          width: 70,
                          height: 40,
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE8F0FF), width: 2),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage('assets/images/products/crop-tops.webp'), // Replace with actual asset
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 25,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE8F0FF), width: 2),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage('assets/images/products/crop-tops-2.webp'), // Replace with actual asset
                                  ),
                                ),
                              ),
                            ],
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
                  const _SummaryRow(title: 'Subtotal (2)', value: 'RS.3500.00'),
                  const SizedBox(height: 12),
                  const _SummaryRow(title: 'Shipping total', value: 'Free'),
                  const SizedBox(height: 12),
                  const _SummaryRow(title: 'Taxes', value: 'RS.500.00'),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('RS.4000.00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order placed successfully')),
                        );
                      },
                      child: const Text(
                        'Place order',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Safe area spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for input fields with labels above them
  Widget _buildInputField(String label, String hint) {
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
          child: Text(
            hint,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Helper widget for Payment selection cards
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