import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Continue silently on error
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential result = await _auth.signInWithCredential(oauthCredential);
      User? user = result.user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      print('🔥 Google Sign-In başlatılıyor...');
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      // Önce mevcut kullanıcıyı çıkar
      await googleSignIn.signOut();

      print('🔥 Google hesap seçimi popup açılıyor...');
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print('❌ Google hesap seçimi iptal edildi veya popup kapandı');
        return null;
      }

      print('✅ Google hesabı seçildi: ${googleUser.email}');
      print('🔥 Google authentication token alınıyor...');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('🔥 Firebase credential oluşturuluyor...');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('🔥 Firebase ile kullanıcı girişi yapılıyor...');
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      print('🎉 Firebase authentication başarılı!');
      print('👤 Kullanıcı: ${user?.email}');
      print('🆔 UID: ${user?.uid}');

      return user;
    } catch (e) {
      print('💥 Google Sign-In hatası: $e');
      print('🔍 Hata türü: ${e.runtimeType}');
      print('🔍 Hata detayı: ${e.toString()}');

      // Firebase Auth hatalarını kontrol et
      if (e is FirebaseAuthException) {
        print('🔥 Firebase Auth Hatası:');
        print('   - Kod: ${e.code}');
        print('   - Mesaj: ${e.message}');
        print('   - Email: ${e.email}');
      }

      return null;
    }
  }
}
