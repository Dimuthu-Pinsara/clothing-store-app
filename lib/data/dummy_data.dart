import '../models/category.dart';
import '../models/product.dart';

final List<Category> dummyCategories = [
  Category(id: '1', name: 'Shoes', icon: '👟'),
  Category(id: '2', name: 'Fashion', icon: '👕'),
  Category(id: '3', name: 'Electronics', icon: '🎧'),
  Category(id: '4', name: 'Beauty', icon: '💄'),
];

final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Nike Air Max',
    image: 'https://picsum.photos/300/300?1',
    category: 'Shoes',
    price: 120.0,
    rating: 4.5,
    description: 'Comfortable sneaker for daily wear.',
    featured: true,
  ),
  Product(
    id: '2',
    name: 'Casual Hoodie',
    image: 'https://picsum.photos/300/300?2',
    category: 'Fashion',
    price: 65.0,
    rating: 4.2,
    description: 'Warm and stylish hoodie.',
    featured: true,
  ),
  Product(
    id: '3',
    name: 'Wireless Headphones',
    image: 'https://picsum.photos/300/300?3',
    category: 'Electronics',
    price: 99.0,
    rating: 4.8,
    description: 'Noise-cancelling premium headphones.',
    featured: true,
  ),
  Product(
    id: '4',
    name: 'Running Shoes',
    image: 'https://picsum.photos/300/300?4',
    category: 'Shoes',
    price: 89.0,
    rating: 4.1,
    description: 'Lightweight running shoes.',
    featured: false,
  ),
];