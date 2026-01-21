#!/usr/bin/env bash
set -e

echo "=== Testing the fixed installation script ==="
echo ""

# Create a temporary test directory
TEST_DIR="/tmp/veil-install-test-$$"
mkdir -p "$TEST_DIR"

echo "Test 1: Verify VEIL_REPO URL is correct"
VEIL_REPO_LINE=$(grep "^VEIL_REPO=" ../install_client.sh | head -1)
echo "Found: $VEIL_REPO_LINE"

if echo "$VEIL_REPO_LINE" | grep -q "veil-core.git"; then
    echo "✓ PASS: VEIL_REPO points to veil-core"
else
    echo "✗ FAIL: VEIL_REPO does not point to veil-core"
    exit 1
fi

echo ""
echo "Test 2: Verify repository can be cloned"
VEIL_REPO="https://github.com/VisageDvachevsky/veil-core.git"
VEIL_BRANCH="main"

git clone --depth 1 --branch "$VEIL_BRANCH" "$VEIL_REPO" "$TEST_DIR/test-clone"
if [ -d "$TEST_DIR/test-clone" ]; then
    echo "✓ PASS: Repository cloned successfully"
    ls -la "$TEST_DIR/test-clone" | head -10
else
    echo "✗ FAIL: Repository clone failed"
    exit 1
fi

echo ""
echo "Test 3: Verify README one-line install URLs"
README_URLS=$(grep "raw.githubusercontent.com" ../README.md | grep "curl -sSL")
echo "Found install commands:"
echo "$README_URLS"

if echo "$README_URLS" | grep -q "veil-core"; then
    echo "✓ PASS: README install URLs point to veil-core"
else
    echo "✗ FAIL: README install URLs incorrect"
    exit 1
fi

# Check for veil-client references
if echo "$README_URLS" | grep -q "veil-client"; then
    echo "✗ FAIL: README still has veil-client references"
    exit 1
fi

echo ""
echo "Test 4: Verify no references to non-existent veil.git"
if grep -r "github.com/VisageDvachevsky/veil\.git" .. --include="*.sh" --include="*.md" 2>/dev/null; then
    echo "✗ FAIL: Found references to non-existent veil.git"
    exit 1
else
    echo "✓ PASS: No references to veil.git found"
fi

# Cleanup
rm -rf "$TEST_DIR"

echo ""
echo "=== All tests passed! ==="
