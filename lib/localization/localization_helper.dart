import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationHelper {
  static Map<String, dynamic> _translations = {};
  static String _currentLanguage = 'tr';

  // Dil dosyasını yükle
  static Future<void> loadLanguage(String languageCode) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/localization/$languageCode.json',
      );
      _translations = json.decode(jsonString);
      _currentLanguage = languageCode;
      print('✅ $languageCode dili yüklendi');
    } catch (e) {
      print('❌ Dil yükleme hatası: $e');
      // Hata durumunda Türkçe'yi yükle
      await loadLanguage('tr');
    }
  }

  // Metni çevir
  static String translate(String key) {
    try {
      return _translations[key] ?? key;
    } catch (e) {
      print('❌ Çeviri hatası: $key - $e');
      return key;
    }
  }

  // Mevcut dili al
  static String get currentLanguage => _currentLanguage;

  // Desteklenen diller
  static List<String> get supportedLanguages => ['tr', 'en'];
}
