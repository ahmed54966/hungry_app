import 'package:go_router/go_router.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/features/auth/view/login_screen_view.dart';
import 'package:hungry/features/auth/view/register_screen_view.dart';
import 'package:hungry/features/checkout/view/checkout_view.dart';
import 'package:hungry/features/checkout/widget/succcess_payment.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/product/view/product_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash.dart';

class RoutesGeneration {
  static GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.splashView,
  routes: [
    GoRoute(path: AppRoutes.registerScreen,
    name: AppRoutes.registerScreen,
    builder: (context, state) => RegisterScreen()),

    GoRoute(path: AppRoutes.loginScreen,
    name: AppRoutes.loginScreen,
    builder: (context, state) => LoginScreen()),

    GoRoute(path: AppRoutes.splashView,
    name: AppRoutes.splashView,
    builder: (context, state) => Splashview()),
    
    GoRoute(path: AppRoutes.rootView,
    name: AppRoutes.rootView,
    builder: (context, state) => Root()),

    GoRoute(
  path: '/productView',
  builder: (context, state) {
    
    final data = state.extra as Map<String, dynamic>; 
    
    final imageUrl = data['url'] as String; 
    final productId = data['id'] as int; 
    final productPrice = data['id'] as int;

    return ProductView(
      imageUrl: imageUrl,
      productId: productId,
      productPrice: productPrice,
    );
  },
),

    GoRoute(path: AppRoutes.homeScreen,
    name: AppRoutes.homeScreen,
    builder: (context, state) => HomeView()),

    GoRoute(
        path: AppRoutes.CheckoutView,
        name: AppRoutes.CheckoutView,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          
        
          final rawPrice = data['orderPrice']; 
          
          int finalPrice = 0;
          if (rawPrice is int) {
            finalPrice = rawPrice;
          } else if (rawPrice is String) {
            
            finalPrice = double.tryParse(rawPrice)?.toInt() ?? 0;
          } else if (rawPrice is double) {
            finalPrice = rawPrice.toInt();
          }

          return CheckoutView(orderPrice: finalPrice);
        },
      ),

    GoRoute(path: AppRoutes.SuccessDialog,
    name: AppRoutes.SuccessDialog,
    builder: (context, state) => SuccessDialog()),

  ]
  );
}