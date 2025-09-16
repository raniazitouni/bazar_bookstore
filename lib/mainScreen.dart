import 'package:flutter/material.dart';
import 'package:bazar_bookstore/features/books/ui/homeScreen.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    Center(child: Text("Category")),
    Center(child: Text("Wishlist")),
    Center(child: Text("Profile")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_selectedIndex]),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            backgroundColor: AppColors.gray50,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.gray500,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  (_selectedIndex == 0)
                      ? 'assets/icons/home_active.svg'
                      : 'assets/icons/home_disabled.svg',
                  width: 24,
                  height: 24,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  (_selectedIndex == 1)
                      ? 'assets/icons/category_active.svg'
                      : 'assets/icons/category_disabled.svg',
                  width: 24,
                  height: 24,
                ),
                label: "category",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  (_selectedIndex == 2)
                      ? 'assets/icons/wishlist_active.svg'
                      : 'assets/icons/wishlist_disabled.svg',
                  width: 24,
                  height: 24,
                ),
                label: "wishlist",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  (_selectedIndex == 3)
                      ? 'assets/icons/profile_active.svg'
                      : 'assets/icons/profile_disabled.svg',
                  width: 24,
                  height: 24,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
