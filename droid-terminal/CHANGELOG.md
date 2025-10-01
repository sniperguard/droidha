# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1] - 2025-10-01

### Fixed
- Changed Droid CLI installation from npm (non-existent package) to official curl installer
- Updated Dockerfile to use `curl -fsSL https://app.factory.ai/cli | sh` for installation
- Added PATH configuration for /root/.local/bin where droid binary is installed
- Updated health check script to verify droid installation correctly
- Removed Node.js and npm dependencies as they're not required

### Changed
- Simplified Dockerfile by removing unnecessary npm dependencies
- Updated installation method to match official Factory documentation

## [1.0.0] - 2025-10-01

### Added
- Initial release of Droid Terminal add-on
- Web-based terminal interface with ttyd
- Droid CLI integration via official installer
- OAuth authentication support
- Persistent configuration storage in /data
- Auto-launch Droid CLI option
- Session picker for advanced users
- Multi-architecture support (amd64, aarch64, armv7)
- Home Assistant configuration directory access
- Health check scripts
- Authentication migration from legacy locations

### Features
- Automatic Droid CLI installation via official curl installer
- Environment variable configuration for XDG standards
- Compatibility symlinks for legacy config locations
- Ingress support for seamless Home Assistant integration
- Admin panel integration

### Security
- Proper file permissions for authentication files
- Secure storage in /data directory
- Home Assistant API integration with manager role
