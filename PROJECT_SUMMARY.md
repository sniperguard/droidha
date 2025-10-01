# Droid Terminal Add-on - Project Summary

## Overview

This project is a Home Assistant add-on that integrates Factory's Droid CLI into Home Assistant, providing a web-based terminal interface accessible directly from the Home Assistant dashboard.

## What Was Created

### Root Level Files
- **repository.yaml** - Repository metadata for Home Assistant add-on store
- **README.md** - Main repository documentation
- **LICENSE** - MIT License
- **SETUP_GUIDE.md** - Comprehensive setup and deployment guide
- **PROJECT_SUMMARY.md** - This file
- **.gitignore** - Git ignore patterns

### Add-on Directory (droid-terminal/)

#### Core Configuration Files
- **config.yaml** - Add-on configuration for Home Assistant
  - Slug: `droid_terminal` (unique identifier)
  - Port: 7682 (different from claude-terminal's 7681)
  - Icon: `mdi:robot-industrial`
  - Auto-launch option support

- **build.yaml** - Multi-architecture build configuration
  - Supports: amd64, aarch64, armv7
  - Uses Home Assistant base images

- **Dockerfile** - Container image definition
  - Installs Node.js, npm, and Droid CLI
  - Sets up working directories
  - Copies scripts and startup files

- **run.sh** - Main startup script
  - Initializes environment variables
  - Sets up /data directory structure
  - Installs ttyd web terminal
  - Handles authentication migration
  - Launches Droid CLI or session picker

#### Documentation Files
- **README.md** - Add-on overview and quick start
- **DOCS.md** - Detailed documentation for users
- **CHANGELOG.md** - Version history and changes

#### Helper Scripts (scripts/)
- **health-check.sh** - System health verification
- **droid-session-picker.sh** - Interactive session menu

## Key Features

### 1. Unique Identifiers
All IDs and names are unique to avoid conflicts:
- Slug: `droid_terminal` (not `claude_terminal`)
- Port: 7682 (not 7681)
- Config path: `/data/.config/droid` (not anthropic)
- Environment vars: `DROID_CONFIG_DIR`, `DROID_HOME`
- Panel title: "Droid Terminal"
- Icon: `mdi:robot-industrial`

### 2. Installation Method
- Uses npm package: `@factory-ai/droid@latest`
- Web terminal via ttyd
- OAuth authentication
- Persistent storage in /data directory

### 3. Configuration Options
- `auto_launch_droid`: Toggle between auto-launch and session picker
- Ingress support for seamless Home Assistant integration
- Full access to Home Assistant config directory

### 4. Multi-Architecture Support
- AMD64 (x86_64)
- ARM64 (aarch64)
- ARMv7 (32-bit ARM)

## Directory Structure

```
droidha/
├── .gitignore
├── LICENSE
├── README.md
├── SETUP_GUIDE.md
├── PROJECT_SUMMARY.md
├── repository.yaml
└── droid-terminal/
    ├── CHANGELOG.md
    ├── DOCS.md
    ├── Dockerfile
    ├── README.md
    ├── build.yaml
    ├── config.yaml
    ├── run.sh
    └── scripts/
        ├── droid-session-picker.sh
        └── health-check.sh
```

## Technical Implementation

### Environment Setup
- Uses XDG Base Directory Specification
- HOME: `/data/home`
- CONFIG: `/data/.config`
- CACHE: `/data/.cache`
- Droid config: `/data/.config/droid`

### Authentication
- OAuth-based authentication
- Persistent credential storage
- Migration from legacy locations
- Secure file permissions (600)

### Web Interface
- ttyd web terminal server
- Port 7682
- Home Assistant ingress support
- Writable terminal for full interaction

## Differences from Reference (claude-terminal)

| Aspect | Claude Terminal | Droid Terminal |
|--------|----------------|----------------|
| Slug | claude_terminal | droid_terminal |
| Port | 7681 | 7682 |
| Icon | mdi:code-braces | mdi:robot-industrial |
| Config Path | /data/.config/anthropic | /data/.config/droid |
| npm Package | @anthropic-ai/claude-code | @factory-ai/droid |
| CLI Command | claude | droid |
| Env Vars | ANTHROPIC_* | DROID_* |

## Next Steps

1. **Update Repository Info**
   - Edit `repository.yaml` with your GitHub username and email
   - Update URLs in `README.md`

2. **Initialize Git**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Droid Terminal add-on"
   ```

3. **Create GitHub Repository**
   - Create public repository on GitHub
   - Push code to repository

4. **Test in Home Assistant**
   - Add repository to Home Assistant
   - Install and test the add-on

5. **Iterate and Improve**
   - Gather feedback
   - Fix issues
   - Add features

## Testing Checklist

- [ ] Add-on installs successfully
- [ ] Add-on starts without errors
- [ ] Web UI opens correctly
- [ ] Droid CLI launches and authenticates
- [ ] Authentication persists after restart
- [ ] Can access /config directory
- [ ] Auto-launch toggle works
- [ ] Session picker works (when auto-launch disabled)
- [ ] Logs show no errors
- [ ] Multi-architecture builds work

## Maintenance

### Updating Droid CLI Version
The addon uses `@factory-ai/droid@latest`, which automatically gets the latest version on each rebuild. To pin a specific version:
1. Edit `Dockerfile`
2. Change `@factory-ai/droid@latest` to `@factory-ai/droid@x.y.z`

### Updating Home Assistant Base Images
Edit `build.yaml` to update the base image versions if needed.

### Version Bumping
1. Update `version` in `config.yaml`
2. Add entry to `CHANGELOG.md`
3. Commit and push

## Support Resources

- Home Assistant Add-on Docs: https://developers.home-assistant.io/docs/add-ons
- Docker Documentation: https://docs.docker.com/
- ttyd Project: https://github.com/tsl0922/ttyd
- Factory Droid: https://factory.ai

## License

MIT License - See LICENSE file for details.

---

**Created:** October 2025  
**Status:** Ready for deployment  
**Author:** Generated for Marcel's Home Assistant setup
