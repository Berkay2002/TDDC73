# Build and run script for lab3_flutter

Write-Host "Building GitHub Trending App..." -ForegroundColor Green

# Get the script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

Write-Host "Working directory: $(Get-Location)" -ForegroundColor Yellow

# Get dependencies
Write-Host "`nGetting dependencies..." -ForegroundColor Cyan
flutter pub get

# Analyze code
Write-Host "`nAnalyzing code..." -ForegroundColor Cyan
flutter analyze --no-fatal-infos

# Run the app
Write-Host "`nRunning app..." -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the app" -ForegroundColor Yellow
flutter run -d windows
