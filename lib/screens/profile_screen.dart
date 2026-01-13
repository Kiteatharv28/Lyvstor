import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/responsive.dart';
import 'auth_screen.dart';
import 'orders_screen.dart';
import 'address_book_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> menuItems = ['Orders', 'Address', 'Wishlist', 'Payment', 'Help', 'Support'];

  Future<void> _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              }
            },
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFEF1F1), Color(0xFFFEDFDF), Color(0xFFFED3D3)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.getResponsiveMaxWidth(context),
              ),
              child: Padding(
                padding: Responsive.getResponsivePadding(context),
                child: Column(
                  children: [
                    SizedBox(height: Responsive.getResponsiveHeight(context, 5)),

                    // Profile Section
                    Column(
                      children: [
                        // Profile Avatar
                        Container(
                          width: Responsive.getResponsiveValue(context, mobile: 100, tablet: 120, desktop: 140),
                          height: Responsive.getResponsiveValue(context, mobile: 100, tablet: 120, desktop: 140),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 3)),

                        // Edit Photo
                        Text(
                          'Edit Photo',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 14),
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 1.5)),

                        // Account Details
                        Text(
                          'Account Details',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 16),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Responsive.getResponsiveHeight(context, 6)),

                    // Menu Items
                    Column(
                      children: List.generate(
                        menuItems.length,
                        (index) => _buildMenuItem(menuItems[index], context),
                      ),
                    ),

                    SizedBox(height: Responsive.getResponsiveHeight(context, 6)),

                    // Sign Out Button
                    GestureDetector(
                      onTap: () => _handleLogout(context),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.getResponsiveButtonHeight(context) / 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: Responsive.getResponsiveBorderRadius(context),
                        ),
                        child: Center(
                          child: Text(
                            'Sign out',
                            style: GoogleFonts.poppins(
                              fontSize: Responsive.getFontSize(context, 16),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: Responsive.getResponsiveHeight(context, 6)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Orders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()),
          );
        } else if (title == 'Address') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressBookScreen()),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: Responsive.getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.getResponsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
          vertical: Responsive.getResponsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300]?.withValues(alpha: 0.5),
          borderRadius: Responsive.getResponsiveBorderRadius(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: Responsive.getFontSize(context, 16),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
              size: Responsive.getResponsiveIconSize(context),
            ),
          ],
        ),
      ),
    );
  }
}
