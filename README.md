# VentureTech Face Attendance System

A complete Flutter application for face-recognition-based attendance tracking with GPS Geofencing, integrated with Google Firebase and Google ML Kit.

## Key Features
- **Live Face Detection & Liveness:** Google ML Kit Face Detection
- **On-Device Embedding Generation:** MobileFaceNet TFLite Model (Zero-cost, offline)
- **Campus GPS Geofencing:** Verifies student is within VentureTech Sheikhupura or Hardev campus boundaries
- **Firebase Firestore Integration:** Real-time logging of attendance and profiles
- **Offline / Zero API Fee:** Completely free architecture

## Project Setup
1. Install Flutter SDK (>= 3.0.0).
2. Run `flutter pub get`.
3. Set up a project in [Firebase Console](https://console.firebase.google.com/).
4. Download `google-services.json` and place it in `android/app/`.
5. Place your `mobilefacenet.tflite` model file inside `assets/models/`.
6. Run the app: `flutter run`.
