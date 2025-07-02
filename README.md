# 🤟 Sign Language Learning App

A modern Flutter-based mobile application to help users learn American Sign Language (ASL), British Sign Language (BSL), and International Sign (IS) through interactive lessons, quizzes, dictionaries, and real-time camera-based sign recognition.

---

## 📱 Features

- **Home Screen:** Sleek dashboard with smooth animations and quick access to all features.
- **Sign Language App:** Camera-based real-time sign recognition (Coming Soon).
- **Sign Dictionaries:** A-Z visual dictionaries for ASL, BSL, and IS.
- **Learn Basics:** Interactive lessons for alphabets, numbers, phrases, and greetings.
- **Quiz Yourself:** Timed quizzes across beginner, intermediate, and advanced levels.
- **Themed UI:** Consistent custom theme using `AppTheme` with primary, accent, and text colors.
- **Animations:** Smooth fade-in and scale animations enhance the UI experience.
- **Search & Filter:** Fast access via dynamic search and filter chips in all modules.
- **Dialog Previews:** Tap cards to view detail previews with placeholder visuals.
- **Accessibility:** High-contrast support, tooltips, and clear labeling.

---

## 📁 Project Structure

```
sign_language_app/
├── lib/
│   ├── constant/
│   │   └── themes.dart              # Theme definitions
│   ├── screens/
│   │   ├── home_screen.dart         # Main dashboard
│   │   ├── sign_dictionary.dart     # ASL, BSL, IS dictionaries
│   │   ├── learn_basic.dart         # Lessons
│   │   ├── sign_quiz.dart           # Quiz module
│   │   └── sign_language_app.dart   # Camera recognition (TBD)
│   └── main.dart                    # Entry point
├── assets/
│   ├── signs/                       # A-Z Sign visuals
│   ├── lessons/                     # Lesson images
│   └── quizzes/                    # Quiz question assets
├── pubspec.yaml                    # Dependencies
└── README.md                       # Project documentation
```

---

## ⚙️ Prerequisites

- Flutter ≥ 3.0.0  
- Dart ≥ 2.17.0  
- Device/emulator (Android/iOS)  
- IDE: VS Code, Android Studio, etc.

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1
  camera: ^0.10.5
```

---

## 🚀 Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/obaidullah72/signbot_flutter_app
   cd sign_language_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure assets**
   - Add images/videos in `assets/signs/`, `assets/lessons/`, and `assets/quizzes/`
   - Update your `pubspec.yaml`:
     ```yaml
     flutter:
       assets:
         - assets/signs/
         - assets/lessons/
         - assets/quizzes/
     ```

4. **Apply custom theme**
   - In `lib/constant/themes.dart`, define your `AppTheme`.
   - Wrap your `MaterialApp` in `main.dart`:
     ```dart
     MaterialApp(
       theme: AppTheme.lightTheme,
       home: HomeScreen(cameras: cameras),
     )
     ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧑‍🏫 Usage Guide

### 🏠 Home Screen
- Navigate to features via animated cards.
- Floating button: access camera-based recognition (TBD).
- Settings icon (Coming Soon).

### 📚 Sign Dictionaries
- Browse A-Z signs for ASL, BSL, IS.
- Search by sign name or language.
- Filter using chips.
- Tap cards for visual + description.

### 📖 Learn Basics
- Learn alphabets, numbers, greetings, phrases.
- Search or filter by category.
- Tap cards for a visual/description dialog.

### 🧠 Quiz Yourself
- Attempt quizzes by difficulty.
- Tap cards to preview sample questions and answers.
- Filter using difficulty chips.

---

## 🔮 Future Improvements

- ✅ **Camera-based Sign Recognition** with TensorFlow Lite.
- 🎯 **Dedicated Screens** for signs, lessons, and quizzes.
- 🎥 **Video tutorials** for sign demonstrations.
- ⚙️ **Settings Screen** for theme, accessibility, and user preferences.
- 📊 **Progress Tracking** for user performance.
- 🌐 **Localization** for multilingual support.

---

## 🤝 Contributing

1. Fork the repo  
2. Create your branch  
   ```bash
   git checkout -b feature/my-feature
   ```
3. Make changes and commit  
   ```bash
   git commit -m "Add my feature"
   ```
4. Push to your fork  
   ```bash
   git push origin feature/my-feature
   ```
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for details.

---

## 📬 Contact

For issues or suggestions, open an issue on the repo or contact:

📧 support@example.com  
📱 +92-XXX-XXXXXXX (optional)

---
