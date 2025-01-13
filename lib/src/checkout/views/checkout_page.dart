import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/addresses/controllers/address_notifier.dart';
import 'package:fashion_app/src/addresses/fetch_default.dart';
import 'package:fashion_app/src/addresses/widgets/address_block.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rzlt = fetchDefaultAddress();
    final address = rzlt.address;
    final isLoading = rzlt.isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<AddressNotifier>().clearAddress();
            context.pop();
          },
        ),
        title: ReusableText(
            text: AppText.kCheckout,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: [
              isLoading
                  ? const SizedBox.shrink()
                  : AddressBlock(
                      address: address,
                    ),
              SizedBox(height: 10.h),
              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                    children: List.generate(
                        cartNotifier.selectedCartItems.length, (i) {
                  return CheckoutTile(cart: cartNotifier.selectedCartItems[i]);
                })),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  color: Kolors.kPrimary, borderRadius: kRadiusTop),
              child: Center(
                child: ReusableText(
                    text: address == null
                        ? 'Please an address'
                        : 'Continue to Payment',
                    style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
              ),
            ),
          );
        },
      ),
    );
  }
}
