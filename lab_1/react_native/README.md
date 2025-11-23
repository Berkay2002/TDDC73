# Lab 1 - React Native Application

## Prerequisites

- Node.js and npm installed
- React Native development environment set up
- For Android: Android Studio and Android SDK
- For iOS: Xcode (macOS only)

## How to Run

1. Navigate to the project directory:
   ```bash
   cd lab_1/react_native
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the application:

   **For Android:**
   ```bash
   npm run android
   ```

   **For iOS (macOS only):**
   ```bash
   npm run ios
   ```

   **For Web (if supported):**
   ```bash
   npm run web
   ```

## Development Commands

- `npm start` - Start the Metro bundler
- `npm run android` - Run on Android device/emulator
- `npm run ios` - Run on iOS simulator (macOS only)
- `npm test` - Run tests

## Hot Reload

React Native supports Fast Refresh by default. Changes to your code will automatically update in the running app.

## Troubleshooting

If you encounter issues:

1. Clear the Metro bundler cache:
   ```bash
   npm start -- --reset-cache
   ```

2. Clean and rebuild:
   ```bash
   cd android && ./gradlew clean
   cd ..
   npm run android
   ```

## Project Structure

- `App.tsx` - Main application component
- `index.js` - Application entry point
- `assets/` - Static assets (images, fonts, etc.)
