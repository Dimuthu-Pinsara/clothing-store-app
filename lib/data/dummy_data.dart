import '../models/category.dart';
import '../models/product.dart';

final List<Category> dummyCategories = [
  Category(id: '1', name: 'T-Shirts', icon: '👕'),
  Category(id: '2', name: 'Shorts', icon: '🩳'),
  Category(id: '3', name: 'Crop-tops', icon: '👚'),
  Category(id: '4', name: 'Denim', icon: '👖'),
];

final List<Product> dummyProducts = [
  Product(
    id: 'SS0150', 
    name: 'Tee Love Mesh Sleeve\nWrap neck Crop Top',
    image: 'https://hkhvnbk2a1.ufs.sh/f/viaFzH8Bk9QshhPjuItyRbANf3McsTLu67UnEIKaWdOB8D5p',
    category: 'Crop-tops',
    price: 2000.00,
    rating: 4.5,
    description: 'Stylish mesh sleeve wrap neck crop top perfect for casual wear and all-day comfort.',
    featured: true,
  ),
  Product(
    id: 'SS0156', 
    name: 'Tee Love Zipper Font\nSchiffli Crop Top',
    image: 'https://hkhvnbk2a1.ufs.sh/f/viaFzH8Bk9QsbByX0eRcD8y6mS3rtpGFxVlOhP2v4gfUnRIw',
    category: 'Crop-tops',
    price: 1500.00,
    rating: 4.8, // Assuming a rating for the UI
    description: 'Offers all-day wearability, making it perfect for casual outings or dressing up for a night out.',
    featured: true,
  ),
  // Added a few extra placeholder products to fill out your other categories
  Product(
    id: 'TS0101',
    name: 'Classic Urban T-Shirt',
    image: 'https://hkhvnbk2a1.ufs.sh/f/viaFzH8Bk9Qs4aAoOVTZVwsW63QvYkKe8lHqcgyxmiz7EdnR',
    category: 'T-Shirts',
    price: 1200.00,
    rating: 4.2,
    description: 'Comfortable everyday cotton t-shirt with a relaxed fit.',
    featured: false,
  ),
  Product(
    id: 'DNM020',
    name: 'High-Rise Vintage Denim',
    image: 'https://hkhvnbk2a1.ufs.sh/f/viaFzH8Bk9QssUgnpoHh97IxQCHqGSOcgAr6NL1XtameoR3T',
    category: 'Denim',
    price: 3500.00,
    rating: 4.6,
    description: 'Classic blue denim jeans with a comfortable high-rise fit and premium stitching.',
    featured: false,
  ),
];