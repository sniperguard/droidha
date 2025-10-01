# Changelog

All notable changes to this project will be documented in this file.

## [1.0.12] - 2025-10-01

### Fixed
- Removed --reconnect flag (not supported by ttyd 1.7.7)
- Fixed "ttyd: unrecognized option: reconnect" error
- Fixed command being parsed as "10 bash..." instead of "bash..."
- Restored proper ttyd command line

## [1.0.11] - 2025-10-01

### Fixed
- Clean up stale lock files on startup
- Prevents "process exited with code 1" on subsequent runs
- Remove any .lock files from droid config and state directories
- Fixes issue where droid works first time but fails after restart

### Changed
- Added lock file cleanup to init_environment function
- Ensures clean state for each droid session

## [1.0.10] - 2025-10-01

### Fixed
- Added --reconnect 10 flag to ttyd for reconnection support
- Prevents killing droid process when browser disconnects
- Allows resuming droid session after connection loss

### Changed
- ttyd now allows reconnection within 10 seconds
- Droid session persists through browser refresh/disconnect

## [1.0.9] - 2025-10-01

### Fixed
- Restored exec droid for proper interactive session
- Droid exits with code 0 after auth, which is expected
- Interactive mode should work now with exec
- Git initialization included before droid starts

### Changed
- Reverted to exec droid for proper terminal takeover
- Simplified command - let droid handle its own session

## [1.0.8] - 2025-10-01

### Changed
- Temporarily remove exec to capture droid error messages
- Show error code and stderr output when droid fails
- Fallback to bash shell after error for debugging
- Keep droid running without exec to see full output

### Debug
- This version helps diagnose why droid exits with code 1
- Will revert to exec once root cause is found

## [1.0.7] - 2025-10-01

### Fixed
- Initialize git repository in /config if not present
- Set git user.name and user.email for droid
- Install git package (droid may require it)
- Fixes "process exited with code 1" after authentication

### Added
- Git initialization before launching droid
- Default git config for addon usage

## [1.0.6] - 2025-10-01

### Fixed
- Use exec to replace shell process with droid
- Prevents premature process termination
- Droid now stays running in foreground properly
- Fixes process being killed with SIGHUP after authentication

### Changed
- Simplified launch command - removed error handling wrapper
- Let droid handle its own lifecycle and errors
- Use exec droid instead of just droid

## [1.0.5] - 2025-10-01

### Fixed
- Added error handling and fallback to bash shell when droid fails
- Explicitly set PATH and working directory before launching droid
- Show error messages when droid exits with non-zero code
- Change to /config directory before starting droid

### Changed
- Enhanced launch command with better error reporting
- Added fallback to bash shell for troubleshooting
- Improved debugging capability

## [1.0.4] - 2025-10-01

### Fixed
- Download prebuilt ttyd binary from GitHub releases instead of apt
- ttyd is not available in Debian bookworm repository
- Use architecture detection via uname -m for Home Assistant compatibility
- Download ttyd v1.7.7 based on detected architecture (x86_64, aarch64, armhf)

### Changed
- Removed ttyd from apt-get install command
- Added separate RUN step to download and install ttyd binary
- More reliable across all supported architectures

## [1.0.3] - 2025-10-01

### Fixed
- Pre-install ttyd and jq in Dockerfile instead of at runtime
- Fixed "ttyd: not found" error preventing addon from starting
- Changed from runtime installation to build-time installation for reliability

### Changed
- Moved ttyd and jq installation to Dockerfile
- Replaced install_tools() with verify_tools() for better error messages
- Tools are now baked into the image, reducing startup time

## [1.0.2] - 2025-10-01

### Fixed
- Switched from Alpine Linux to Debian base images to fix glibc compatibility
- Droid binary requires glibc which Alpine's musl doesn't provide
- Updated package manager commands from apk to apt-get
- Fixed "cannot execute: required file not found" error

### Changed
- Base images: Now using ghcr.io/home-assistant/*-base-debian:bookworm
- Package installation: Changed from apk to apt-get with proper cleanup
- Maintains all functionality with proper library support

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
