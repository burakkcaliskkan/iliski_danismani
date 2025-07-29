import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import '../localization/localization_helper.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleAppleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithApple();
      if (user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Apple ile giriş başarısız. Lütfen tekrar deneyin.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Google ile giriş başarısız. Lütfen tekrar deneyin.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              LocalizationHelper.translate('app_title'),
              style: TextStyle(fontSize: 38, color: AppColors.textDark),
            ),
            const SizedBox(height: 28),
            Text(
              LocalizationHelper.translate('onboarding_subtitle'),
              style: TextStyle(fontSize: 16, color: AppColors.textGray),
            ),
            const SizedBox(height: 8),
            Text(
              LocalizationHelper.translate('onboarding_welcome'),
              style: TextStyle(fontSize: 16, color: AppColors.textGray),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/cift_illut.jpg',
              width: MediaQuery.of(context).size.width * 0.8,
              height: 450,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(300, 50),
              ),
              onPressed: _isLoading ? null : _handleAppleSignIn,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(LocalizationHelper.translate('sign_in_with_apple')),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(300, 50),
              ),
              onPressed: _isLoading ? null : _handleGoogleSignIn,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(LocalizationHelper.translate('sign_in_with_google')),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
