import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/auth/domain/bottomnavbar_controller.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/booking_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/profile_screen.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [DashboardScreen(), BookingScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    final navProvider = ref.watch(navBarProvider);
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: screens[navProvider.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navProvider.selectedIndex,
          backgroundColor: Colors.grey[100],
          elevation: 1,
          selectedItemColor: CommonColors.primaryColor,
          onTap: (index) {
            ref.read(navBarProvider).updateSelectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
