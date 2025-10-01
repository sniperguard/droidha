# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-01-XX

### Added
- Initial release of Droid Terminal add-on
- Web-based terminal interface with ttyd
- Droid CLI integration
- OAuth authentication support
- Persistent configuration storage in /data
- Auto-launch Droid CLI option
- Session picker for advanced users
- Multi-architecture support (amd64, aarch64, armv7)
- Home Assistant configuration directory access
- Health check scripts
- Authentication migration from legacy locations

### Features
- Automatic Droid CLI installation via npm
- Environment variable configuration for XDG standards
- Compatibility symlinks for legacy config locations
- Ingress support for seamless Home Assistant integration
- Admin panel integration

### Security
- Proper file permissions for authentication files
- Secure storage in /data directory
- Home Assistant API integration with manager role
