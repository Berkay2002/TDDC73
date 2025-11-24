#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

DEMO_DIR="project/primitive_demo"
BUILD_OUTPUT_DIR="build/web"
TARGET_DEPLOY_DIR="docs/primitive_demo_web"

echo "Starting Flutter web build for primitive_demo..."

# Navigate to the demo project directory
cd "$DEMO_DIR"

# Build the Flutter web application in release mode
# The base-href is already set in web/index.html
flutter build web --release

echo "Flutter web build completed."

# Navigate back to the project root
cd ../..

echo "Copying build artifacts to $TARGET_DEPLOY_DIR..."

# Create the target deployment directory if it doesn't exist
mkdir -p "$TARGET_DEPLOY_DIR"

# Clear existing content in the target directory
rm -rf "$TARGET_DEPLOY_DIR"/*

# Copy the built files to the target directory
cp -r "$DEMO_DIR/$BUILD_OUTPUT_DIR"/* "$TARGET_DEPLOY_DIR"/

echo "Deployment artifacts ready in $TARGET_DEPLOY_DIR."
echo "You can now push these changes to GitHub and configure GitHub Pages."
