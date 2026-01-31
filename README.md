# SelfHelp - Anxiety Relief App

A minimalist Android app to help users manage anxiety through scientifically-backed exercises.

## Features

- **Box Breathing (4-4-4-4)** - Navy SEAL technique for stress relief
- **4-7-8 Breathing** - Dr. Andrew Weil's relaxing breath technique
- **5-4-3-2-1 Grounding** - CBT technique for panic attacks
- **Progressive Muscle Relaxation** - Systematic tension release
- **Body Scan Meditation** - Mindfulness-based stress reduction
- **Counting Breath Meditation** - Simple focus meditation

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio or VS Code with Flutter extension
- Android device or emulator

### Installation

1. Install Flutter: https://docs.flutter.dev/get-started/install

2. Clone this repository and navigate to it:
   ```bash
   cd SelfHelp
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Generate App Icons

Before building for release, generate proper app icons:

1. Create a 1024x1024 PNG icon at `assets/icon/app_icon.png`
2. Create a 1024x1024 PNG foreground for adaptive icon at `assets/icon/app_icon_foreground.png`
3. Run:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

## Building for Release

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # MaterialApp configuration
├── theme/
│   └── app_theme.dart           # Calming color palette, typography
├── models/
│   └── exercise.dart            # Exercise data models
├── screens/
│   ├── home_screen.dart         # Exercise list/grid
│   ├── exercise_detail_screen.dart  # Exercise explanation
│   └── exercise_session_screen.dart # Active exercise with animations
├── widgets/
│   ├── exercise_card.dart       # Home screen card
│   ├── breathing_circle.dart    # Animated breathing guide
│   ├── breathing_square.dart    # Box breathing animation
│   ├── body_diagram.dart        # PMR/Body scan visual
│   ├── grounding_steps.dart     # 5-4-3-2-1 step cards
│   └── session_timer.dart       # Duration timer
├── data/
│   └── exercises_data.dart      # Exercise content/instructions
└── utils/
    └── haptic_feedback.dart     # Gentle haptic cues
```

## Design

### Color Palette
- Primary: Soft blue (#6B9AC4)
- Secondary: Sage green (#93B5A0)
- Background: Off-white (#FAFAFA)
- Surface: White (#FFFFFF)
- Text: Soft charcoal (#2D3436)
- Accent: Lavender (#B4A7D6)

### UX Principles
- No clutter - single purpose screens
- Smooth, slow animations (calming effect)
- Minimal navigation depth (2 taps to start any exercise)
- Optional gentle haptic feedback
- Works fully offline

## Testing

```bash
flutter test
```

## Play Store Deployment

1. Generate a signing key (keep it safe!):
   ```bash
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. Create `android/key.properties` (don't commit this!):
   ```
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```

3. Update `android/app/build.gradle` to use the signing config

4. Build the app bundle:
   ```bash
   flutter build appbundle --release
   ```

5. Upload to Play Console

## Privacy

This app:
- Does not collect any personal data
- Does not require internet access
- Works completely offline
- Does not include any analytics or tracking

## License

MIT License
