# SelfHelp App - Implementation Context

This document summarizes the implementation of the SelfHelp anxiety relief app for context in future sessions.

## Project Overview

A minimalist Flutter Android app providing 6 scientifically-backed anxiety relief exercises with calming animations and no internet requirement.

## Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **Target**: Android (SDK 21-34), expandable to iOS
- **Dependencies**:
  - `google_fonts` - Nunito typography
  - `flutter_animate` - Animation utilities
  - `flutter_launcher_icons` - App icon generation

## Architecture

```
lib/
├── main.dart                    # Entry point, system UI config
├── app.dart                     # MaterialApp, theme setup
├── theme/app_theme.dart         # Colors, spacing, animation durations
├── models/exercise.dart         # Data models (Exercise, BreathingPhase, etc.)
├── data/exercises_data.dart     # All exercise content and configurations
├── screens/
│   ├── home_screen.dart         # Grid of exercise cards
│   ├── exercise_detail_screen.dart   # Info, benefits, start button
│   └── exercise_session_screen.dart  # All 6 exercise implementations
├── widgets/
│   ├── exercise_card.dart       # Home screen card widget
│   ├── breathing_circle.dart    # 4-7-8 expanding circle animation
│   ├── breathing_square.dart    # Box breathing with traversing dot
│   ├── grounding_steps.dart     # 5-4-3-2-1 interactive cards
│   ├── body_diagram.dart        # Body outline for PMR/scan
│   └── session_timer.dart       # Elapsed time display
└── utils/haptic_feedback.dart   # Haptic feedback helper
```

## Implemented Exercises

| Exercise | Type | Animation | Interaction |
|----------|------|-----------|-------------|
| Box Breathing | 4-4-4-4 timing | Square with dot traversing edges | Auto-timed |
| 4-7-8 Breathing | 4-7-8 timing | Circle expands/contracts with progress ring | Auto-timed |
| 5-4-3-2-1 Grounding | Sensory grounding | Step cards with progress dots | User taps to count |
| Progressive Muscle Relaxation | Tense/relax cycle | Body diagram highlights regions | Auto-timed |
| Body Scan | Mindfulness | Body diagram with region focus | Auto-timed |
| Counting Breath | 1-10 count | Simple expanding circle | Auto-timed |

## Design System

### Colors (Calming Palette)
- Primary: `#6B9AC4` (soft blue)
- Secondary: `#93B5A0` (sage green)
- Background: `#FAFAFA` (off-white)
- Surface: `#FFFFFF` (white)
- Text: `#2D3436` (soft charcoal)
- Accent: `#B4A7D6` (lavender)
- Additional: `#F5CAC3` (warm peach), `#D4E4ED` (pale blue), `#D4EDDA` (mint green)

### UX Principles
- 2 taps max to start any exercise
- Slow, smooth animations
- No clutter - single purpose screens
- Optional haptic feedback
- Fully offline

## Key Implementation Details

### Exercise Session Screen (`exercise_session_screen.dart`)
- Single stateful widget handles all 6 exercise types
- Uses `Timer.periodic` for timing
- State variables for each exercise type (phase index, seconds remaining, etc.)
- Three states: start screen → active exercise → completion screen
- Haptic feedback on phase transitions

### Breathing Animations
- `BreathingCircle`: Uses `CustomPainter` for progress arc, `AnimatedScale` for breathing effect
- `BreathingSquare`: Custom painter draws square path with animated dot position

### Grounding Exercise
- User-paced (no timer)
- Tap circles to count items for each sense
- Auto-advances to next step when count reached

### Body Diagram
- Custom painter draws simplified body outline
- Highlights active region based on string matching
- Different opacity for tense vs relax states

## Android Configuration

- `applicationId`: com.selfhelp.selfhelp
- `minSdk`: 21 (Android 5.0)
- `targetSdk`: 34 (Android 14)
- ProGuard enabled for release builds
- No permissions required (fully offline)

## What's NOT Implemented

- iOS configuration (structure exists but not configured)
- Actual PNG app icons (SVG placeholder exists)
- Audio guidance (visual-only by design)
- User preferences/settings
- Exercise history/tracking
- Onboarding flow

## To Run

```bash
flutter pub get
flutter run
```

## To Build Release

```bash
flutter build appbundle --release
```

## Files to Update Before Play Store

1. Generate app icons from `assets/icon/app_icon.svg`
2. Create signing key and `android/key.properties`
3. Update signing config in `android/app/build.gradle`
4. Add privacy policy URL to Play Console

## Testing

Basic tests in `test/widget_test.dart` verify:
- App renders home screen
- All 6 exercises have required data
- Breathing phase timings are correct
- Grounding follows 5-4-3-2-1 pattern

---

*Last updated: January 2025*
*Implemented by Claude in a single session*
