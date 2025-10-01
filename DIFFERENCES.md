# Differences Between Claude Terminal and Droid Terminal

This document highlights all the differences between the original claude-terminal addon and the new droid-terminal addon to ensure no conflicts.

## Configuration Identifiers

| Property | Claude Terminal | Droid Terminal | Status |
|----------|----------------|----------------|---------|
| **Slug** | `claude_terminal` | `droid_terminal` | ✅ Different |
| **Name** | "Claude Terminal" | "Droid Terminal" | ✅ Different |
| **Port** | 7681 | 7682 | ✅ Different |
| **Icon** | `mdi:code-braces` | `mdi:robot-industrial` | ✅ Different |
| **Panel Title** | "Claude Terminal" | "Droid Terminal" | ✅ Different |

## File System Paths

| Location | Claude Terminal | Droid Terminal | Status |
|----------|----------------|----------------|---------|
| **Config Directory** | `/data/.config/anthropic` | `/data/.config/droid` | ✅ Different |
| **Legacy Path 1** | `/root/.config/anthropic` | `/root/.config/droid` | ✅ Different |
| **Legacy Path 2** | `/root/.anthropic` | `/root/.droid` | ✅ Different |
| **Legacy Path 3** | `/config/claude-config` | `/config/droid-config` | ✅ Different |
| **Scripts Directory** | `/opt/scripts/` | `/opt/scripts/` | ⚠️ Same (different files) |

## Environment Variables

| Variable | Claude Terminal | Droid Terminal | Status |
|----------|----------------|----------------|---------|
| **Config Dir** | `ANTHROPIC_CONFIG_DIR` | `DROID_CONFIG_DIR` | ✅ Different |
| **Home** | `ANTHROPIC_HOME` | `DROID_HOME` | ✅ Different |
| **XDG Variables** | Standard XDG | Standard XDG | ✅ Same (OK) |

## NPM Package & Commands

| Item | Claude Terminal | Droid Terminal | Status |
|------|----------------|----------------|---------|
| **NPM Package** | `@anthropic-ai/claude-code` | `@factory-ai/droid` | ✅ Different |
| **CLI Command** | `claude` | `droid` | ✅ Different |
| **Version** | `@latest` | `@latest` | ✅ Same (OK) |

## Configuration Options

| Option | Claude Terminal | Droid Terminal | Status |
|--------|----------------|----------------|---------|
| **Auto-launch** | `auto_launch_claude` | `auto_launch_droid` | ✅ Different |
| **Default Value** | `true` | `true` | ✅ Same (OK) |

## Script Files

| Script | Claude Terminal | Droid Terminal | Status |
|--------|----------------|----------------|---------|
| **Session Picker** | `claude-session-picker.sh` | `droid-session-picker.sh` | ✅ Different |
| **Auth Helper** | `claude-auth-helper.sh` | `droid-auth-helper.sh` | ✅ Different |
| **Health Check** | `health-check.sh` | `health-check.sh` | ✅ Same (generic) |

## Function Names in run.sh

| Function | Claude Terminal | Droid Terminal | Status |
|----------|----------------|----------------|---------|
| **Launch Command** | `get_claude_launch_command()` | `get_droid_launch_command()` | ✅ Different |
| **Other Functions** | Generic names | Generic names | ✅ Same (OK) |

## URL References

| Reference | Claude Terminal | Droid Terminal | Status |
|-----------|----------------|----------------|---------|
| **Project URL** | `https://github.com/anthropics/claude-code` | `https://github.com/factory-ai/droid` | ✅ Different |
| **Repository** | `heytcass/home-assistant-addons` | `marcel/droidha` | ✅ Different |

## Docker Labels

| Label | Claude Terminal | Droid Terminal | Status |
|-------|----------------|----------------|---------|
| **Title** | "Claude Terminal" | "Droid Terminal" | ✅ Different |
| **Description** | "Anthropic's Claude Code CLI" | "Factory's Droid CLI" | ✅ Different |
| **Source** | Anthropic URL | Factory URL | ✅ Different |

## UI Messages

| Message Context | Claude Terminal | Droid Terminal | Status |
|----------------|----------------|----------------|---------|
| **Welcome** | "Welcome to Claude Terminal!" | "Welcome to Droid Terminal!" | ✅ Different |
| **Starting** | "Starting Claude..." | "Starting Droid..." | ✅ Different |
| **Log Messages** | References "Claude" | References "Droid" | ✅ Different |

## Architecture Support

| Architecture | Claude Terminal | Droid Terminal | Status |
|-------------|----------------|----------------|---------|
| **amd64** | ✅ Supported | ✅ Supported | ✅ Same (OK) |
| **aarch64** | ✅ Supported | ✅ Supported | ✅ Same (OK) |
| **armv7** | ✅ Supported | ✅ Supported | ✅ Same (OK) |

## Base Images

| Architecture | Claude Terminal | Droid Terminal | Status |
|-------------|----------------|----------------|---------|
| **All** | `ghcr.io/home-assistant/*-base:3.19` | `ghcr.io/home-assistant/*-base:3.19` | ✅ Same (OK) |

## Summary

### ✅ All Critical Identifiers Are Different
- No slug conflicts
- No port conflicts
- No file system conflicts
- No environment variable conflicts
- No command conflicts

### ✅ Can Coexist Peacefully
Both addons can be installed on the same Home Assistant instance without any conflicts. They:
- Use different ports
- Store data in different directories
- Use different environment variables
- Have different configuration options
- Use different CLI commands

### ⚠️ One Potential Note
The base path `/data` is used by both (as required by Home Assistant), but each creates its own subdirectories, so there's no conflict.

## Testing Checklist

When testing both addons together:
- [ ] Both can be installed simultaneously
- [ ] Both can run at the same time
- [ ] Each maintains separate authentication
- [ ] No cross-contamination of config files
- [ ] Logs are separate and clear
- [ ] UI panels appear separately
- [ ] Both are accessible via their own ports/ingress

## Conclusion

✅ **The droid-terminal addon is fully independent and will NOT conflict with claude-terminal.**

All critical identifiers, paths, and names have been changed to ensure complete separation while maintaining the same functionality pattern.
