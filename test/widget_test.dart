// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:iliski_burak/main.dart';

/// Basic widget tests for the Relationship Helper app
/// Tests the main app initialization and basic functionality
void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('İlişki Yardımcısı'), findsOneWidget);

    // Verify that onboarding screen is shown initially
    expect(find.text('Hoş Geldin!'), findsOneWidget);
  });

  testWidgets('Onboarding screen elements test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that sign-in buttons are present
    expect(find.text('Apple ile Giriş Yap'), findsOneWidget);
    expect(find.text('Google ile Giriş Yap'), findsOneWidget);
  });
}
