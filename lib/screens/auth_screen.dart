import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../providers/auth_provider.dart';
import '../utils/responsive.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorSnackBar('Please fill all fields');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else if (mounted && authProvider.error != null) {
      _showErrorSnackBar(authProvider.error!);
    }
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showErrorSnackBar('Please fill all fields');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      name: _nameController.text.trim(),
    );

    if (success && mounted) {
      _showSuccessSnackBar('Account created successfully!');
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        }
      });
    } else if (mounted && authProvider.error != null) {
      _showErrorSnackBar(authProvider.error!);
    }
  }

  Future<void> _handleForgotPassword(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      _showErrorSnackBar('Please enter your email');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.resetPassword(
      email: _emailController.text.trim(),
    );

    if (success && mounted) {
      _showSuccessSnackBar('Password reset email sent!');
    } else if (mounted && authProvider.error != null) {
      _showErrorSnackBar(authProvider.error!);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Responsive.getResponsiveHeight(context, 8)),

                        // Logo
                        Text(
                          'Lyvstor',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 32),
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 5)),

                        // Tab Buttons
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: Responsive.getResponsiveBorderRadius(context),
                            border: Border.all(
                              color: const Color(0xFFE8D5D5),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLogin = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Responsive.getResponsiveValue(
                                        context,
                                        mobile: 12,
                                        tablet: 14,
                                        desktop: 16,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isLogin ? Colors.black : Colors.transparent,
                                      borderRadius: Responsive.getResponsiveBorderRadius(context),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Log In',
                                        style: GoogleFonts.poppins(
                                          fontSize: Responsive.getFontSize(context, 14),
                                          fontWeight: FontWeight.w600,
                                          color: _isLogin ? Colors.white : const Color(0xFF999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLogin = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Responsive.getResponsiveValue(
                                        context,
                                        mobile: 12,
                                        tablet: 14,
                                        desktop: 16,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: !_isLogin ? Colors.white : Colors.transparent,
                                      borderRadius: Responsive.getResponsiveBorderRadius(context),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign up',
                                        style: GoogleFonts.poppins(
                                          fontSize: Responsive.getFontSize(context, 14),
                                          fontWeight: FontWeight.w600,
                                          color: !_isLogin ? Colors.black : const Color(0xFF999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 5)),

                        // Name Field (Sign up only)
                        if (!_isLogin) ...[
                          Text(
                            'Full Name',
                            style: GoogleFonts.poppins(
                              fontSize: Responsive.getFontSize(context, 12),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: Responsive.getResponsiveHeight(context, 1.5)),
                          _buildTextField(
                            context: context,
                            controller: _nameController,
                            hintText: 'Enter your full name',
                          ),
                          SizedBox(height: Responsive.getResponsiveHeight(context, 3)),
                        ],

                        // Email Field
                        Text(
                          'Email Address',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 12),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 1.5)),
                        _buildTextField(
                          context: context,
                          controller: _emailController,
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 3)),

                        // Password Field
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 12),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 1.5)),
                        _buildPasswordField(context),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 2)),

                        // Remember Me & Forgot Password
                        if (_isLogin)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _rememberMe ? const Color(0xFFD4A5A5) : const Color(0xFFE8D5D5),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                        color: _rememberMe ? const Color(0xFFD4A5A5) : Colors.transparent,
                                      ),
                                      child: _rememberMe
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 12,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Remember me',
                                      style: GoogleFonts.poppins(
                                        fontSize: Responsive.getFontSize(context, 11),
                                        color: const Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showForgotPasswordDialog();
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.poppins(
                                    fontSize: Responsive.getFontSize(context, 11),
                                    color: const Color(0xFFD4A5A5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 5)),

                        // Submit Button
                        GestureDetector(
                          onTap: authProvider.isLoading
                              ? null
                              : (_isLogin
                                  ? () => _handleLogin(context)
                                  : () => _handleSignUp(context)),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.getResponsiveButtonHeight(context) / 3,
                            ),
                            decoration: BoxDecoration(
                              color: authProvider.isLoading ? Colors.grey : Colors.black,
                              borderRadius: Responsive.getResponsiveBorderRadius(context),
                            ),
                            child: Center(
                              child: authProvider.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      _isLogin ? 'Log In' : 'Create Account',
                                      style: GoogleFonts.poppins(
                                        fontSize: Responsive.getFontSize(context, 14),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 3)),

                        // Sign up / Log in link
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: _isLogin ? "Don't have an account? " : "Already have an account? ",
                              style: GoogleFonts.poppins(
                                fontSize: Responsive.getFontSize(context, 11),
                                color: const Color(0xFF999999),
                              ),
                              children: [
                                TextSpan(
                                  text: _isLogin ? 'Sign up' : 'Log in',
                                  style: GoogleFonts.poppins(
                                    fontSize: Responsive.getFontSize(context, 11),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFD4A5A5),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveHeight(context, 10)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: Responsive.getFontSize(context, 13),
          color: const Color(0xFF999999),
        ),
        border: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFE8D5D5),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFE8D5D5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFD4A5A5),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.getResponsiveValue(context, mobile: 14, tablet: 16, desktop: 18),
          vertical: Responsive.getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
        ),
      ),
      style: GoogleFonts.poppins(
        fontSize: Responsive.getFontSize(context, 13),
        color: Colors.black,
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: GoogleFonts.poppins(
          fontSize: Responsive.getFontSize(context, 13),
          color: const Color(0xFF999999),
        ),
        border: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFE8D5D5),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFE8D5D5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: Responsive.getResponsiveBorderRadius(context),
          borderSide: const BorderSide(
            color: Color(0xFFD4A5A5),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.getResponsiveValue(context, mobile: 14, tablet: 16, desktop: 18),
          vertical: Responsive.getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          child: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFFCCCCCC),
            size: Responsive.getResponsiveIconSize(context),
          ),
        ),
      ),
      style: GoogleFonts.poppins(
        fontSize: Responsive.getFontSize(context, 13),
        color: Colors.black,
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Reset Password',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email to receive a password reset link',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: resetEmailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              _emailController.text = resetEmailController.text;
              Navigator.pop(context);
              _handleForgotPassword(context);
            },
            child: Text(
              'Send',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
