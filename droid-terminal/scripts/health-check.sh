#!/bin/bash
# Health check script for Droid Terminal add-on

echo "Running system health checks..."

# Add droid to PATH for check
export PATH="/root/.local/bin:$PATH"

# Check if Droid is installed
if command -v droid &> /dev/null; then
    echo "✓ Droid CLI installed: $(droid --version 2>&1 | head -1 || echo 'version unknown')"
else
    echo "⚠ Droid CLI not found in /root/.local/bin"
    exit 1
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
