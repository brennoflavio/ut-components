#!/bin/bash

set -e

DOWNLOAD_URL="https://github.com/brennoflavio/ut-components/archive/refs/tags/v1.0-rc2.zip"
TEMP_DIR="/tmp/ut-components-install-$$"
ZIP_FILE="$TEMP_DIR/ut-components.zip"
EXTRACTED_DIR="$TEMP_DIR/ut-components-1.0-rc2"

echo "Installing UT Components library..."

mkdir -p "$TEMP_DIR"

echo "Downloading library from $DOWNLOAD_URL..."
curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"

echo "Extracting library..."
unzip -q "$ZIP_FILE" -d "$TEMP_DIR"

echo "Removing old installation if exists..."
rm -rf qml/ut_components
rm -rf src/ut_components

echo "Installing library components..."
mkdir -p qml
mkdir -p src
cp -r "$EXTRACTED_DIR/src/qml" "qml/ut_components"
cp -r "$EXTRACTED_DIR/src/python" "src/ut_components"

echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "UT Components library installed successfully!"
echo "  - QML components: qml/ut_components"
echo "  - Python components: src/ut_components"
