# Lab 1 - Kotlin XML

A simple Android application built with Kotlin and traditional XML layouts demonstrating a basic UI layout.

## Features

- Teal top bar with title
- Centered image placeholder
- 2x2 grid of buttons
- Email input field with label

## Prerequisites

- Java Development Kit (JDK) 8 or higher
- Android SDK
- Android Debug Bridge (ADB)
- Android Studio (optional, for emulator)

## Setup

The project uses Gradle wrapper, so you don't need to install Gradle separately.

## Running the App

### Option 1: Using Android Emulator

1. Start an Android emulator from Android Studio (Tools > Device Manager)
2. Navigate to the project directory:
   ```bash
   cd c:\Users\berka\Masters\TDDC73\lab_1\kotlin_xml
   ```
3. Build and install the app:
   ```bash
   .\gradlew.bat installDebug
   ```
4. The app will be installed and can be launched from the emulator

### Option 2: Using Physical Device

1. Enable Developer Options and USB Debugging on your Android device
2. Connect your device via USB
3. Verify the connection:
   ```bash
   adb devices
   ```
4. Navigate to the project directory and install:
   ```bash
   cd c:\Users\berka\Masters\TDDC73\lab_1\kotlin_xml
   .\gradlew.bat installDebug
   ```

### Option 3: Build APK for Manual Installation

1. Build the debug APK:
   ```bash
   .\gradlew.bat assembleDebug
   ```
2. The APK will be located at: `app\build\outputs\apk\debug\app-debug.apk`
3. Transfer and install the APK on your device

## Project Structure

```
kotlin_xml/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/example/lab1xml/
│   │       │   └── MainActivity.kt
│   │       ├── res/
│   │       │   └── layout/
│   │       │       └── activity_main.xml
│   │       └── AndroidManifest.xml
│   └── build.gradle.kts
├── gradle/
│   └── wrapper/
├── build.gradle.kts
├── settings.gradle.kts
└── gradlew.bat
```

## UI Layout

The UI is defined using ConstraintLayout in `activity_main.xml`, featuring:
- Custom top bar using a View with teal background
- ImageView for central image
- Four Material Design buttons in a grid layout
- Email input with TextView label and EditText field

## Other Gradle Commands

- Clean the project: `.\gradlew.bat clean`
- Build debug APK: `.\gradlew.bat assembleDebug`
- Build release APK: `.\gradlew.bat assembleRelease`
- Run tests: `.\gradlew.bat test`
- List all tasks: `.\gradlew.bat tasks`
