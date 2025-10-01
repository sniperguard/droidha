# Manual Git Setup Instructions

Git requires accepting the Xcode license agreement on your Mac before it can be used.

## Step 1: Accept Xcode License

Open Terminal and run:
```bash
sudo xcodebuild -license
```

Then press Space to scroll through the license, type `agree` when prompted, and enter your password.

## Step 2: Initialize Git Repository

```bash
cd /Users/marcel/Development/droidha

# Initialize git repository
git init

# Check status
git status
```

## Step 3: Stage All Files

```bash
# Add all files to git
git add .

# Verify what will be committed
git status
```

## Step 4: Create Initial Commit

```bash
# Create the commit
git commit -m "Initial commit: Droid Terminal add-on for Home Assistant

- Add Droid Terminal add-on for Home Assistant
- Web-based terminal with Droid CLI integration
- Multi-architecture support (amd64, aarch64, armv7)
- OAuth authentication with persistent storage
- Session picker and auto-launch modes
- Comprehensive documentation and setup guides

Unique identifiers to avoid conflicts with claude-terminal:
- Slug: droid_terminal
- Port: 7682
- Icon: mdi:robot-industrial
- Config path: /data/.config/droid"

# Verify commit was created
git log --oneline
```

## Step 5: Create GitHub Repository

### Option A: Using GitHub CLI (recommended)

```bash
# Make sure you're authenticated
gh auth login

# Create repository (choose public)
gh repo create droidha --public --source=. --description="Home Assistant add-on for Factory's Droid CLI"

# Push to GitHub
gh repo sync
```

### Option B: Using GitHub Website

1. Go to https://github.com/new
2. Repository name: `droidha`
3. Description: "Home Assistant add-on for Factory's Droid CLI"
4. Visibility: **Public** (required for Home Assistant add-ons)
5. Do NOT initialize with README, license, or .gitignore
6. Click "Create repository"

Then connect your local repo:

```bash
# Add the remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/droidha.git

# Rename branch to main
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 6: Verify on GitHub

Visit your repository URL and verify:
- [ ] All files are present
- [ ] README.md displays correctly
- [ ] Repository is marked as Public
- [ ] No errors or warnings

## Step 7: Update Repository URLs

Now that you have the actual repository URL, update these files:

### Update repository.yaml

```bash
# Replace YOUR_USERNAME with your actual GitHub username
nano repository.yaml
```

Change:
```yaml
url: https://github.com/YOUR_USERNAME/droidha
maintainer: Marcel <your.email@example.com>
```

### Update README.md

```bash
nano README.md
```

Update the installation URL in the README.

### Commit the changes

```bash
git add repository.yaml README.md
git commit -m "Update repository URLs with actual GitHub username"
git push
```

## Step 8: Add Topics to GitHub Repository

On GitHub, go to your repository and add these topics:
- homeassistant
- home-assistant-addon
- droid
- terminal
- cli
- automation

## Step 9: Add to Home Assistant

Now follow the instructions in QUICK_START.md to add the repository to your Home Assistant instance.

## Troubleshooting

### "permission denied" when pushing
- Check you're authenticated: `gh auth status`
- Re-authenticate: `gh auth login`
- Or use SSH instead of HTTPS

### "repository not found"
- Verify repository was created on GitHub
- Check the remote URL: `git remote -v`
- Make sure you're using the correct username

### "failed to push some refs"
- Pull first: `git pull origin main --rebase`
- Then push: `git push -u origin main`

## Quick Command Summary

```bash
# Accept Xcode license
sudo xcodebuild -license

# Initialize and commit
cd /Users/marcel/Development/droidha
git init
git add .
git commit -m "Initial commit: Droid Terminal add-on for Home Assistant"

# Create and push to GitHub (using gh CLI)
gh auth login
gh repo create droidha --public --source=. --description="Home Assistant add-on for Factory's Droid CLI"
git push -u origin main

# Or manually set remote
git remote add origin https://github.com/YOUR_USERNAME/droidha.git
git branch -M main
git push -u origin main
```

## Next Steps

Once pushed to GitHub, continue with QUICK_START.md Step 3 to add the repository to Home Assistant.
