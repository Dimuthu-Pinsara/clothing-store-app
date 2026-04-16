import 'package:flutter/material.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/primary_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String paymentMethod = 'Cash on Delivery';

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CustomTextField(hintText: 'Full Name'),
            const SizedBox(height: 12),
            const CustomTextField(hintText: 'Phone Number'),
            const SizedBox(height: 12),
            const CustomTextField(hintText: 'Address'),
            const SizedBox(height: 12),
            const CustomTextField(hintText: 'City'),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: [
                  RadioListTile(
                    value: 'Cash on Delivery',
                    groupValue: paymentMethod,
                    onChanged: (_) {},
                    title: const Text('Cash on Delivery'),
                  ),
                  RadioListTile(
                    value: 'Card Payment',
                    groupValue: paymentMethod,
                    onChanged: (_) {},
                    title: const Text('Card Payment'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Place Order',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order placed successfully')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}