# Droid Terminal Add-on Documentation

## Overview

The Droid Terminal add-on provides a web-based terminal interface that integrates Factory's Droid CLI directly into your Home Assistant instance. Access it through your Home Assistant UI and use Droid's AI-powered capabilities for automation, configuration, and development tasks.

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the "Droid Terminal" add-on
3. Start the add-on
4. Click "OPEN WEB UI" to access the terminal

## Configuration

### Options

#### auto_launch_droid (optional)
- **Type**: boolean
- **Default**: true
- **Description**: When enabled, Droid CLI will automatically launch when you open the terminal. When disabled, you'll see a session picker menu.

Example configuration:
```yaml
auto_launch_droid: true
```

## Usage

### First Time Setup

1. Open the Droid Terminal from your Home Assistant sidebar
2. On first launch, Droid will prompt you to authenticate
3. Follow the OAuth flow to connect your Factory account
4. Your authentication will be saved and persist across restarts

### Accessing Home Assistant Configuration

The add-on provides direct access to your Home Assistant configuration directory at `/config`. You can use Droid to:

- Edit configuration files
- Create and modify automations
- Debug issues
- Generate new configurations

### Session Management

If you disable `auto_launch_droid`, you can:
- Choose to start a new Droid session
- Resume existing sessions
- Access a plain bash shell

## Features

- **Persistent Authentication**: Your Droid credentials are saved securely
- **Configuration Access**: Direct access to Home Assistant config files
- **Web-based Terminal**: No SSH required
- **Multi-architecture Support**: Works on amd64, aarch64, and armv7

## Troubleshooting

### Authentication Issues

If you encounter authentication problems:
1. Check the add-on logs
2. Try restarting the add-on
3. Re-authenticate through the OAuth flow

### Performance Issues

If the terminal feels slow:
- Check your Home Assistant system resources
- Restart the add-on
- Check network connectivity

### Can't Access Configuration Files

Ensure the add-on has proper permissions:
- Check that the `config:rw` mapping is enabled
- Verify Home Assistant permissions

## Support

For issues, questions, or contributions, please visit the GitHub repository.

## Privacy & Security

- Authentication tokens are stored locally in the add-on's data directory
- All communication with Factory's servers uses HTTPS
- No data is shared with third parties
- The add-on runs with manager role permissions for Home Assistant API access
