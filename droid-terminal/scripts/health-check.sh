#!/bin/bash
# Health check script for Droid Terminal add-on

echo "Running system health checks..."

# Check Node.js installation
if command -v node &> /dev/null; then
    echo "✓ Node.js installed: $(node --version)"
else
    echo "✗ Node.js not found"
    exit 1
fi

# Check npm installation
if command -v npm &> /dev/null; then
    echo "✓ npm installed: $(npm --version)"
else
    echo "✗ npm not found"
    exit 1
fi

# Check if Droid is installed
if command -v droid &> /dev/null; then
    echo "✓ Droid CLI installed"
else
    echo "⚠ Droid CLI not found - will be installed on first run"
fi

# Check ttyd installation
if command -v ttyd &> /dev/null; then
    echo "✓ ttyd installed"
else
    echo "✗ ttyd not found"
    exit 1
fi

# Check required directories
if [ -d "/data" ]; then
    echo "✓ /data directory exists"
else
    echo "✗ /data directory not found"
    exit 1
fi

# Check write permissions
if [ -w "/data" ]; then
    echo "✓ /data is writable"
else
    echo "✗ /data is not writable"
    exit 1
fi

echo "Health check completed successfully!"
exit 0
