import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/auth/domain/bottomnavbar_controller.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/booking_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/my_history_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/setting_screen.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  List<Widget> screens = [
    DashboardScreen(),
    BookingScreen(),
    MyHistoryScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(navBarProvider).clearSelectedIndex();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = ref.watch(navBarProvider);
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: screens[navProvider.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: navProvider.selectedIndex,
          backgroundColor: Colors.grey[100],
          elevation: 1,
          selectedItemColor: CommonColors.primaryColor,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          unselectedFontSize: 9,
          onTap: (index) {
            ref.read(navBarProvider).updateSelectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
