import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/src/cart/views/cart_page.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_app/src/home/views/home_page.dart';
import 'package:fashion_app/src/profile/views/profile_page.dart';
import 'package:fashion_app/src/wishlist/views/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntrypoint extends StatelessWidget {
  AppEntrypoint({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const WishlistPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabIndexNotifier>(
        builder: (context, tabIndexNotifier, child) {
      return Scaffold(
        body: Stack(
          children: [
            pageList[tabIndexNotifier.index],
            Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data:
                      Theme.of(context).copyWith(canvasColor: Kolors.kOffWhite),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    elevation: 0,
                    backgroundColor: Kolors.kOffWhite,
                    showSelectedLabels: true,
                    selectedLabelStyle:
                        appStyle(9, Kolors.kPrimary, FontWeight.w500),
                    showUnselectedLabels: false,
                    currentIndex: tabIndexNotifier.index,
                    selectedItemColor: Kolors.kPrimary,
                    unselectedItemColor: Kolors.kGray,
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black38),
                    onTap: (i) {
                      tabIndexNotifier.setIndex(i);
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: tabIndexNotifier.index == 0
                              ? const Icon(
                                  AntDesign.home,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : const Icon(
                                  AntDesign.home,
                                  size: 24,
                                ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: tabIndexNotifier.index == 1
                              ? const Icon(
                                  Ionicons.heart,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : const Icon(
                                  Ionicons.heart_outline,
                                  color: Kolors.kPrimary,
                                ),
                          label: "Wishlist"),
                      BottomNavigationBarItem(
                          icon: tabIndexNotifier.index == 2
                              ? const Badge(
                                  label: Text('9'),
                                  child: Icon(
                                    MaterialCommunityIcons.shopping,
                                    color: Kolors.kPrimary,
                                    size: 24,
                                  ),
                                )
                              : const Badge(
                                  label: Text('9'),
                                  child: Icon(
                                    MaterialCommunityIcons.shopping_outline,
                                  ),
                                ),
                          label: "Cart"),
                      BottomNavigationBarItem(
                          icon: tabIndexNotifier.index == 3
                              ? const Icon(
                                  EvilIcons.user,
                                  color: Kolors.kPrimary,
                                  size: 34,
                                )
                              : const Icon(
                                  EvilIcons.user,
                                  size: 34,
                                ),
                          label: "Profile"),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
