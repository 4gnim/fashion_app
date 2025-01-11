import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/auth/views/login_page.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/cart/hooks/fetch_cart.dart';
import 'package:fashion_app/src/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final carts = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;

    if (accessToken == null) {
      return const LoginPage();
    }

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: AppText.kCart,
            style: appStyle(15, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(carts.length, (i) {
          final cart = carts[i];
          return CartTile(
            cart: cart,
            onDelete: () {
              context.read<CartNotifier>().deleteCart(cart.id, refetch);
            },
            onUpdate: () {
              context.read<CartNotifier>().updateCart(cart.id, refetch);
            },
          );
        }),
      ),
    );
  }
}
