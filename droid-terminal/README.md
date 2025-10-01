# Droid Terminal Add-on

A Home Assistant add-on that provides a web-based terminal interface with Factory's Droid CLI pre-installed.

## Features

- Web terminal access through Home Assistant UI
- Pre-installed Droid CLI with automatic launch
- Persistent OAuth authentication
- Direct access to Home Assistant configuration directory
- Multi-architecture support (amd64, aarch64, armv7)

## Installation

1. Add the repository URL to your Home Assistant add-on store
2. Find "Droid Terminal" in the add-on list
3. Click Install
4. Start the add-on
5. Click "OPEN WEB UI"

## Configuration

```yaml
auto_launch_droid: true
```

### Options

- `auto_launch_droid` (optional): Automatically launch Droid CLI when opening the terminal (default: true)

## Usage

Access the terminal from your Home Assistant sidebar. On first run, you'll be prompted to authenticate with your Factory account. Your authentication will persist across restarts.

## Documentation

For detailed documentation, see [DOCS.md](./DOCS.md)

## Support

For issues and questions, please create an issue in the repository.
