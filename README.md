# Relationship Helper

A Flutter application designed to help users manage and improve their relationships through AI-powered advice and relationship status tracking.

## Features

### 🔐 Authentication
- **Apple Sign-In**: Secure authentication using Apple ID
- **Google Sign-In**: Quick login with Google account
- **Firebase Integration**: Robust backend authentication system

### 💕 Relationship Management
- **Add Relationships**: Create detailed profiles for people you're interested in
- **Track Status**: Monitor relationship progress and current situations
- **Edit & Delete**: Manage your relationship entries with full CRUD operations
- **Detailed Profiles**: Store comprehensive information including:
  - Personal details (name, age, profession)
  - Relationship status (single, married, complicated, etc.)
  - Physical condition and lifestyle
  - Current situation (social media, first meeting, etc.)
  - Special notes and observations

### 🤖 AI Relationship Advisor
- **Chat Interface**: Interactive chat with AI advisor
- **Quick Questions**: Pre-defined common relationship questions
- **Personalized Advice**: Get tailored relationship guidance
- **Multiple Topics**: Cover conversation topics, meeting ideas, messaging suggestions

### 🎨 User Interface
- **Modern Design**: Clean and intuitive user interface
- **Responsive Layout**: Works seamlessly across different screen sizes
- **Color-coded Elements**: Easy-to-navigate with consistent theming
- **Smooth Navigation**: Intuitive flow between screens

## Technical Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
- **Authentication**: Firebase Auth
- **Database**: Cloud Firestore
- **State Management**: Flutter's built-in StatefulWidget
- **UI Framework**: Material Design

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── onboarding_screen.dart
│   ├── dashboard_screen.dart
│   ├── durumlar_screen.dart
│   ├── durum_ekle_screen.dart
│   ├── durum_duzenle_screen.dart
│   ├── profil_detay_screen.dart
│   └── ai_danisman_screen.dart
├── services/                 # Business logic
│   ├── auth_service.dart
│   └── firestore_service.dart
└── utils/                    # Utilities
    └── colors.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Firebase project setup
- Apple Developer Account (for Apple Sign-In)
- Google Cloud Console setup (for Google Sign-In)

### Installation
1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Configure Firebase:
   - Add `google-services.json` (Android)
   - Add `GoogleService-Info.plist` (iOS)
4. Run the app: `flutter run`

## Development Notes

- All code is thoroughly documented with English comments
- Follows Flutter best practices and conventions
- Implements proper error handling and user feedback
- Uses async/await for all database operations
- Includes comprehensive widget lifecycle management

## Contributing

This project is designed for educational purposes and relationship management. Feel free to contribute improvements or report issues.

## License

This project is for educational and personal use.
