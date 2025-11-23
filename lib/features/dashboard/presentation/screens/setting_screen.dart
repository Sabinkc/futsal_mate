import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/common/theme_provider.dart';
import 'package:futsalmate/common/utils.dart';
import 'package:futsalmate/features/auth/data/firebase_authservice.dart';
import 'package:futsalmate/features/auth/data/loggedinstate_sharedpref.dart';
import 'package:futsalmate/features/auth/presentation/screens/signin_screen.dart';
import 'package:futsalmate/features/dashboard/presentation/screens/profile_screen.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Manage your profile and preferences",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            // Profile Section
            _buildProfileSection(context),
            const SizedBox(height: 30),

            // Settings Options
            Expanded(
              child: Column(
                children: [
                  // Theme Option
                  // _buildSettingCard(
                  //   context: context,
                  //   title: "Theme",
                  //   subtitle: "Change app theme",
                  //   icon: Icons.color_lens_rounded,
                  //   iconColor: Colors.purple,
                  //   backgroundColor: Colors.purple.shade50,
                  //   onTap: () {
                  //     _showThemeDialog(context, ref, currentTheme);
                  //   },
                  //   trailing: _getThemeName(currentTheme),
                  // ),
                  // const SizedBox(height: 16),

                  // Profile Option
                  _buildSettingCard(
                    context: context,
                    title: "My Profile",
                    subtitle: "View and edit your profile",
                    icon: Icons.person_rounded,
                    iconColor: Colors.blue,
                    backgroundColor: Colors.blue.shade50,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Logout Option
                  _buildSettingCard(
                    context: context,
                    title: "Log Out",
                    subtitle: "Sign out from your account",
                    icon: Icons.logout_rounded,
                    iconColor: Colors.red,
                    backgroundColor: Colors.red.shade50,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CommonColors.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Manage your account settings",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
    String? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trailing,
                  style: TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(
    BuildContext context,
    WidgetRef ref,
    AppTheme currentTheme,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              ctx,
              ref,
              AppTheme.light,
              'Light Theme',
              Icons.light_mode,
              currentTheme,
            ),
            _buildThemeOption(
              ctx,
              ref,
              AppTheme.dark,
              'Dark Theme',
              Icons.dark_mode,
              currentTheme,
            ),
            _buildThemeOption(
              ctx,
              ref,
              AppTheme.system,
              'System Default',
              Icons.settings,
              currentTheme,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    AppTheme theme,
    String title,
    IconData icon,
    AppTheme currentTheme,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: currentTheme == theme
          ? Icon(Icons.check, color: CommonColors.primaryColor)
          : null,
      onTap: () {
        ref.read(themeProvider.notifier).setTheme(theme);
        Navigator.of(context).pop();
        Utils.showCommonSnackBar(
          context,
          content: 'Theme changed to $title',
          color: CommonColors.primaryColor,
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                final firebaseAuth = FirebaseAuthservice();
                final sharedPref = LoggedinstateSharedpref();
                await firebaseAuth.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                }
                sharedPref.clearUserUid();
              } catch (e) {
                if (context.mounted) {
                  Utils.showCommonSnackBar(
                    context,
                    content: e.toString(),
                    color: CommonColors.errorColor,
                  );
                }
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  String _getThemeName(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.system:
        return 'System';
    }
  }
}
