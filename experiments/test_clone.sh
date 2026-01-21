#!/usr/bin/env bash
set -e

# Test 1: Clone with HTTPS
echo "=== Test 1: Clone veil-core with HTTPS ==="
git clone --depth 1 https://github.com/VisageDvachevsky/veil-core.git /tmp/test-veil-core-1 && echo "SUCCESS" || echo "FAILED"
rm -rf /tmp/test-veil-core-1

# Test 2: Clone with .git suffix
echo ""
echo "=== Test 2: Clone veil-core with .git suffix ==="
git clone --depth 1 https://github.com/VisageDvachevsky/veil-core.git /tmp/test-veil-core-2 && echo "SUCCESS" || echo "FAILED"
rm -rf /tmp/test-veil-core-2

# Test 3: Check if veil-core has any content
echo ""
echo "=== Test 3: Check veil-core repository contents ==="
git clone --depth 1 https://github.com/VisageDvachevsky/veil-core.git /tmp/test-veil-core-3
ls -la /tmp/test-veil-core-3/ | head -20
rm -rf /tmp/test-veil-core-3

echo ""
echo "All tests completed!"
