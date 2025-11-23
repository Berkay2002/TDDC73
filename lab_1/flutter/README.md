# Lab 1 - Flutter Application

## Prerequisites

- Flutter SDK installed
- Windows development tools (for Windows platform)

## How to Run

1. Navigate to the project directory:
   ```bash
   cd lab_1/flutter
   ```

2. Get dependencies (if needed):
   ```bash
   flutter pub get
   ```

3. Run the application on Windows:
   ```bash
   flutter run -d windows
   ```

   Or simply:
   ```bash
   flutter run
   ```

## Available Commands While Running

- `r` - Hot reload (apply code changes without restarting)
- `R` - Hot restart (restart the app)
- `h` - List all available commands
- `d` - Detach (leave app running in background)
- `c` - Clear the screen
- `q` - Quit (terminate the application)

## Supported Platforms

- Windows (configured)

To add support for other platforms (iOS, Android, web, etc.), run:
```bash
flutter create --platforms=<platform> .
```

Replace `<platform>` with: `ios`, `android`, `web`, `macos`, `linux`, etc.
