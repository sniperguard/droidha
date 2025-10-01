# Droid Terminal Add-on Setup Guide

This guide will help you set up and publish your Droid Terminal add-on for Home Assistant.

## Prerequisites

- A GitHub account
- A Home Assistant instance (for testing)
- Basic knowledge of Git

## Step 1: Create GitHub Repository

1. Go to GitHub and create a new repository
2. Name it `droidha` (or your preferred name)
3. Make it public (required for Home Assistant add-on repositories)
4. Don't initialize with README (we already have one)

## Step 2: Initialize Git and Push to GitHub

```bash
cd /Users/marcel/Development/droidha

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Droid Terminal add-on for Home Assistant"

# Add your GitHub repository as remote (replace with your actual repo URL)
git remote add origin https://github.com/YOUR_USERNAME/droidha.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Update Repository Information

Before pushing, update these files with your actual information:

### repository.yaml
```yaml
name: Droid Terminal for Home Assistant
url: https://github.com/YOUR_USERNAME/droidha
maintainer: Your Name <your.email@example.com>
```

### README.md
Replace the repository URL in the installation instructions with your actual GitHub URL.

## Step 4: Add to Home Assistant

Once your repository is on GitHub:

1. Open your Home Assistant instance
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click the **⋮** (three dots) menu in the top right
4. Select **Repositories**
5. Add your repository URL: `https://github.com/YOUR_USERNAME/droidha`
6. Click **Add**
7. Close and refresh the add-on store
8. Find "Droid Terminal" in the list
9. Click it and then click **Install**

## Step 5: Configure and Start

1. After installation, click on the Droid Terminal add-on
2. Go to the **Configuration** tab
3. Set any desired options (auto_launch_droid defaults to true)
4. Go to the **Info** tab
5. Click **Start**
6. Wait for it to start (check logs if there are issues)
7. Click **Open Web UI**

## Step 6: First Use

1. When you first open the terminal, Droid will prompt for authentication
2. Follow the OAuth flow to connect your Factory account
3. Your credentials will be saved and persist across restarts

## Troubleshooting

### Add-on won't start

Check the logs:
1. Go to the add-on page
2. Click the **Log** tab
3. Look for error messages

Common issues:
- npm registry issues: Wait and try again
- Permission issues: Check Home Assistant logs

### Can't authenticate with Droid

1. Make sure you have a valid Factory account
2. Check your internet connection
3. Try restarting the add-on
4. Check if the Droid CLI package is correctly installed

### Repository not showing in add-on store

1. Make sure the repository is public
2. Verify the URL is correct
3. Check that repository.yaml is in the root directory
4. Try removing and re-adding the repository

## Advanced Configuration

### Auto-launch Droid

To disable auto-launch and see the session picker:

```yaml
auto_launch_droid: false
```

### Custom Scripts

You can add custom scripts to the `droid-terminal/scripts/` directory. Make sure to:
1. Make them executable
2. Update the Dockerfile if needed
3. Reference them in run.sh

## Development and Testing

### Local Testing with Docker

```bash
cd droid-terminal

# Build for your architecture
docker build --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19 -t droid-terminal-local .

# Run locally
docker run -p 7682:7682 -v $(pwd)/test-data:/data droid-terminal-local
```

### Making Changes

1. Edit files locally
2. Commit changes: `git commit -am "Description of changes"`
3. Push to GitHub: `git push`
4. In Home Assistant, reinstall or update the add-on

### Version Updates

When releasing a new version:
1. Update `version` in `droid-terminal/config.yaml`
2. Update `CHANGELOG.md` with changes
3. Commit and push to GitHub
4. Users can then update the add-on

## Key Differences from Claude Terminal

This add-on has been specifically designed for Droid CLI with:

- **Different slugs**: `droid_terminal` (vs `claude_terminal`)
- **Different ports**: 7682 (vs 7681)
- **Different icons**: `mdi:robot-industrial` (vs `mdi:code-braces`)
- **Different config paths**: `/data/.config/droid` (vs `/data/.config/anthropic`)
- **Different environment variables**: `DROID_CONFIG_DIR`, `DROID_HOME`
- **Different npm package**: `@factory-ai/droid` (vs `@anthropic-ai/claude-code`)

This ensures no conflicts if both add-ons are installed.

## Support and Contributing

- Report issues on GitHub
- Submit pull requests for improvements
- Share your experience with the community

## Resources

- [Home Assistant Add-on Documentation](https://developers.home-assistant.io/docs/add-ons)
- [Factory Droid Documentation](https://factory.ai/docs)
- [Docker Documentation](https://docs.docker.com/)
