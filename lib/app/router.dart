import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/product/product_list_screen.dart';
import '../screens/product/product_detail_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: AuthProvider(),
  redirect: (context, state) {
    final isAuthenticated = context.read<AuthProvider>().isAuthenticated;
    final isGoingToLogin = state.matchedLocation == '/';
    final isGoingToRegister = state.matchedLocation == '/register';

    // If not logged in, and not trying to login/register, kick to login
    if (!isAuthenticated && !isGoingToLogin && !isGoingToRegister) {
      return '/';
    }

    // If logged in, but trying to go to login screen, kick to home
    if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
      return '/home';
    }

    return null; // No redirect needed
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);