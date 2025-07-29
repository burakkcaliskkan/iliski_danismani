import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'localization/localization_helper.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase başarıyla başlatıldı');
  } catch (e) {
    print('Firebase hatası: $e');
  }

  // Sistem dilini algıla ve localization'ı başlat
  final String systemLanguage =
      WidgetsBinding.instance.window.locale.languageCode;
  print('🌍 Sistem dili: $systemLanguage');

  // Desteklenen dilleri kontrol et
  try {
    if (LocalizationHelper.supportedLanguages.contains(systemLanguage)) {
      await LocalizationHelper.loadLanguage(systemLanguage);
    } else {
      // Desteklenmiyorsa Türkçe kullan
      await LocalizationHelper.loadLanguage('tr');
    }
    print('✅ Localization başarıyla yüklendi');
  } catch (e) {
    print('❌ Localization yükleme hatası: $e');
    // Hata durumunda Türkçe'yi zorla yükle
    try {
      await LocalizationHelper.loadLanguage('tr');
    } catch (e2) {
      print('❌ Türkçe yükleme de başarısız: $e2');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İlişki Yardımcısı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingScreen(),
    );
  }
}
