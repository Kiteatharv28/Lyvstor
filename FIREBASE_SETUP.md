# Firebase Setup Guide

## Issue
Firebase initialization is failing because the credentials in `firebase_options.dart` are placeholder/dummy values.

## Solution

### Step 1: Get Your Firebase Credentials

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Go to Project Settings (gear icon)
4. Download configuration files:
   - **Android**: `google-services.json`
   - **iOS**: `GoogleService-Info.plist`
   - **Web**: Copy credentials from Firebase Console

### Step 2: Update Firebase Options

Replace the dummy values in `lib/firebase_options.dart` with your actual credentials:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_API_KEY',
  appId: '1:YOUR_PROJECT_NUMBER:android:YOUR_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

### Step 3: Android Setup

1. Place `google-services.json` in `android/app/`
2. Ensure `android/build.gradle` has:
```gradle
buildscript {
  dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
  }
}
```

3. Ensure `android/app/build.gradle` has:
```gradle
apply plugin: 'com.google.gms.google-services'
```

### Step 4: iOS Setup

1. Place `GoogleService-Info.plist` in `ios/Runner/`
2. Add to Xcode project (if not auto-added)
3. Run: `cd ios && pod install && cd ..`

### Step 5: Web Setup

Add to `web/index.html` in the `<head>` section:

```html
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-firestore.js"></script>
```

### Step 6: Test

Run your app:
```bash
flutter run
```

## Troubleshooting

### Error: "Firebase initialization failed"
- Check that credentials are correct
- Verify `google-services.json` is in correct location
- Ensure Firebase project is active

### Error: "Permission denied"
- Check Firestore security rules
- Verify user is authenticated
- Check Firebase Console for errors

### Error: "Project not found"
- Verify `projectId` matches Firebase Console
- Check internet connection
- Ensure Firebase project is created

## Quick Test

To verify Firebase is working:

```dart
// In any screen
try {
  final user = FirebaseAuth.instance.currentUser;
  print('Firebase working! User: $user');
} catch (e) {
  print('Firebase error: $e');
}
```

## Security Note

⚠️ **Never commit real Firebase credentials to version control!**

Use environment variables or `.env` files:

```dart
// Example with dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';

static const FirebaseOptions android = FirebaseOptions(
  apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
  appId: String.fromEnvironment('FIREBASE_APP_ID'),
  // ...
);
```

## Resources

- [Firebase Console](https://console.firebase.google.com/)
- [FlutterFire Setup](https://firebase.flutter.dev/docs/overview)
- [Firebase Security Rules](https://firebase.google.com/docs/firestore/security/start)

## Next Steps

1. Get real Firebase credentials
2. Update `firebase_options.dart`
3. Add configuration files to Android/iOS
4. Test on device
5. Deploy to production

---

**Once configured, your app will work perfectly!** 🚀
