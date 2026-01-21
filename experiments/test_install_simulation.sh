#!/usr/bin/env bash
set -e

# Simulate the exact line from install_client.sh
VEIL_REPO="https://github.com/VisageDvachevsky/veil-core.git"
VEIL_BRANCH="main"
BUILD_DIR="/tmp/veil-test-$$"

echo "Simulating installation clone..."
echo "VEIL_REPO=$VEIL_REPO"
echo "VEIL_BRANCH=$VEIL_BRANCH"
echo "BUILD_DIR=$BUILD_DIR"
echo ""

# Clean up
rm -rf "$BUILD_DIR"

# Try the exact command from the script
echo "Running: git clone --depth 1 --branch $VEIL_BRANCH $VEIL_REPO $BUILD_DIR"
git clone --depth 1 --branch "$VEIL_BRANCH" "$VEIL_REPO" "$BUILD_DIR"

if [ -d "$BUILD_DIR" ]; then
    echo ""
    echo "SUCCESS! Repository cloned to $BUILD_DIR"
    ls -la "$BUILD_DIR" | head -10
    rm -rf "$BUILD_DIR"
else
    echo "FAILED! Directory not created"
fi
