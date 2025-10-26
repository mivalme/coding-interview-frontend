# ElDorado Exchange — Flutter

🧠 **Clean Architecture**, ⚙️ **Cubit/BLoC**, and ⚡ **Dio** for network handling.

<div align="center">
  <img src="https://github.com/user-attachments/assets/f3b8525f-c9d4-45b7-bae2-6c244c876294" width="250" alt="App Screenshot">
  <br>
  <em>Simple, and scalable currency converter UI.</em>
</div>

---

## ✨ Features

✅ Convert **FIAT → CRYPTO** and **CRYPTO → FIAT**  
✅ Dynamic currency pickers with modal sheets  
✅ Live quote with:
- 💰 **Rate**
- 🎯 **Converted value**
- ⏱️ **ETA**

✅ Clean, testable architecture with **Cubit** states  

---

## 🏗️ Architecture

This app follows **Clean Architecture**.

```
┌─────────── UI (Widgets) ───────────┐
│   Presentation Layer               │
│   - Pages & Widgets                │
│   - Cubits / States                │
└───────────────▲────────────────────┘
                │ uses
┌───────────────┴────────────────────┐
│   Domain Layer                     │
│   - Entities                       │
│   - Use cases                      │
│   - Repositories                   │
└───────────────▲────────────────────┘
                │ implements
┌───────────────┴────────────────────┐
│   Data Layer                       │
│   - Repository impls               │
│   - Data sources                   │
│   - Models / mappers               │
└───────────────▲────────────────────┘
                │ via
┌───────────────┴────────────────────┐
│   Core Layer                       │
│   - config                         │
│   - di                             │
│   - network                        │
│   - router                         │
│   - constants                      │
└────────────────────────────────────┘
```

---

## 🧰 Tech stack

| Category | Library / Tool | Purpose |
|-----------|----------------|----------|
| 🐦 UI Framework | **Flutter 3.35.x** | Cross-platform app |
| 💬 State Management | **flutter_bloc / bloc** | Cubit architecture |
| 🌍 HTTP Client | **Dio** | API requests |
| 🧪 Testing | **bloc_test, mocktail** | Unit testing |
| 🧱 Language | **Dart 3.9.x** | Null-safe & fast |

---

## 🚀 Getting started

### ⚡ Requirements
- Flutter SDK 3.35.x  
- Dart SDK 3.9.x  
- Xcode / Android Studio

### 📦 Install dependencies

```bash
flutter pub get
```

For iOS:
```bash
cd ios && pod install && cd ..
```

---

## ▶️ Running the app

```bash
flutter run -d <device_id>
```

💡 Tip: Use `flutter devices` to list available simulators/emulators.

---

## 🧪 Testing

Run all unit tests:

```bash
flutter test
```

### 🧩 Covered Tests

- **ExchangeCubit**
  - Emits correct states for FIAT→CRYPTO and CRYPTO→FIAT
  - Handles exceptions gracefully  
- **ExchangeRepoImpl**
  - Maps API model → `Recommendation`
  - Validates `rateFiatToCrypto` and ETA parsing
  - Ensures correct API call forwarding

🧠 Tests focus on **logic only**, keeping UI independent.

---

## 🧠 Author

👨‍💻 **Miguel Valcárcel**  
Mobile Software Engineer (Flutter / iOS)  
