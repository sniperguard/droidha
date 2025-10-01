# Pre-Deployment Checklist

Complete this checklist before deploying your Droid Terminal add-on to ensure everything is properly configured.

## ☑️ Required Actions

### 1. Update Repository Information

- [ ] Edit `repository.yaml`
  - [ ] Replace maintainer name
  - [ ] Replace maintainer email
  - [ ] Update repository URL if different from `https://github.com/marcel/droidha`

- [ ] Edit root `README.md`
  - [ ] Update repository URL in installation instructions
  - [ ] Update any personal information

### 2. Verify NPM Package Name

The Dockerfile currently installs `@factory-ai/droid@latest`

- [ ] Verify this is the correct npm package name for Droid CLI
- [ ] Check Factory documentation for the official package
- [ ] Update `Dockerfile` line 9 if package name is different
- [ ] Consider pinning to specific version instead of `@latest` for stability

### 3. Create GitHub Repository

- [ ] Create a new **PUBLIC** repository on GitHub
- [ ] Name it `droidha` (or your preferred name)
- [ ] Do NOT initialize with README/License (we already have them)
- [ ] Copy the repository URL for next step

### 4. Initialize Git

```bash
cd /Users/marcel/Development/droidha

# Initialize
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Droid Terminal add-on for Home Assistant"

# Add remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/droidha.git

# Push to GitHub
git branch -M main
git push -u origin main
```

- [ ] Git repository initialized
- [ ] Remote added
- [ ] Pushed to GitHub
- [ ] Verify files appear on GitHub

## ☑️ Optional But Recommended

### 5. Add Repository Description

On GitHub:
- [ ] Add description: "Home Assistant add-on for Factory's Droid CLI"
- [ ] Add topics: `homeassistant`, `home-assistant-addon`, `droid`, `terminal`
- [ ] Update repository details

### 6. Local Testing (Advanced)

If you have Docker:

```bash
cd droid-terminal

# Build test image
docker build --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19 -t droid-terminal-test .

# Run test container
docker run -p 7682:7682 -v $(pwd)/test-data:/data droid-terminal-test
```

- [ ] Test build completes without errors
- [ ] Container starts successfully
- [ ] Can access terminal on http://localhost:7682

### 7. Documentation Review

- [ ] Read through QUICK_START.md
- [ ] Familiarize yourself with SETUP_GUIDE.md
- [ ] Review DIFFERENCES.md to understand uniqueness
- [ ] Check PROJECT_SUMMARY.md for technical details

## ☑️ Pre-Installation Verification

### 8. Repository Structure Check

Verify your repository has:
```
droidha/
├── .gitignore ✓
├── LICENSE ✓
├── README.md ✓
├── repository.yaml ✓
└── droid-terminal/
    ├── config.yaml ✓
    ├── build.yaml ✓
    ├── Dockerfile ✓
    ├── run.sh ✓
    └── scripts/ ✓
```

- [ ] All required files present
- [ ] Scripts are executable (run.sh, *.sh in scripts/)
- [ ] No extra/unwanted files committed

### 9. File Content Verification

Check these files contain your updated information:

- [ ] `repository.yaml` - Your name, email, URL
- [ ] `README.md` - Correct repository URL
- [ ] `droid-terminal/config.yaml` - Version set to "1.0.0"
- [ ] `Dockerfile` - Correct npm package name

## ☑️ Home Assistant Installation

### 10. Add Repository

In Home Assistant:
1. Go to Settings → Add-ons → Add-on Store
2. Click ⋮ (three dots menu) → Repositories
3. Add your repository URL
4. Click Add

- [ ] Repository added successfully
- [ ] No error messages

### 11. Install Add-on

1. Refresh add-on store
2. Find "Droid Terminal"
3. Click Install

Watch the logs during installation:
- [ ] Download completes
- [ ] Build completes (may take several minutes)
- [ ] No error messages in log

### 12. First Run

1. Click Configuration tab
2. Review settings (auto_launch_droid: true)
3. Go to Info tab
4. Click Start
5. Wait for "Started" status

- [ ] Add-on starts successfully
- [ ] No errors in logs
- [ ] Status shows "Running"

### 13. Web UI Test

1. Click "OPEN WEB UI"
2. Terminal should load
3. Droid should start or prompt for authentication

- [ ] Terminal interface loads
- [ ] Droid CLI appears
- [ ] Can interact with terminal

### 14. Authentication Test

1. Follow OAuth flow if prompted
2. Sign in with Factory account
3. Verify Droid is functional

- [ ] Authentication completes
- [ ] Droid responds to commands
- [ ] Session persists after refresh

### 15. Persistence Test

1. Restart the add-on
2. Re-open Web UI

- [ ] Authentication persists
- [ ] No need to re-authenticate
- [ ] Droid works immediately

## ☑️ Final Checks

### 16. Configuration Access

Test Home Assistant config access:
```bash
ls /config
cat /config/configuration.yaml
```

- [ ] Can see /config directory
- [ ] Can read HA configuration files
- [ ] Droid can access files for editing

### 17. Multi-Architecture (Optional)

If you have different devices:
- [ ] Test on amd64 (x86_64)
- [ ] Test on aarch64 (Raspberry Pi 4, etc.)
- [ ] Test on armv7 (older Raspberry Pi)

### 18. Documentation

- [ ] Update CHANGELOG.md with release date
- [ ] Create GitHub release (optional)
- [ ] Share repository with community (optional)

## ⚠️ Common Issues

### Build Fails
- Check npm package name is correct
- Verify internet connectivity
- Check Home Assistant logs for details

### Can't Start Add-on
- Review add-on logs
- Check port 7682 isn't in use
- Verify /data directory permissions

### Authentication Fails
- Confirm Factory account is valid
- Check internet connectivity
- Review Droid CLI documentation

### Can't Access Config
- Verify `map: config:rw` in config.yaml
- Check Home Assistant permissions
- Restart add-on

## 🎉 Success Criteria

You're ready to go when:
- ✅ Add-on installs without errors
- ✅ Add-on starts and shows "Running"
- ✅ Web UI loads and shows terminal
- ✅ Droid CLI is functional
- ✅ Authentication works and persists
- ✅ Can access /config directory
- ✅ Logs show no errors

## 📝 Next Steps After Deployment

1. Use Droid to explore Home Assistant
2. Test automations and configurations
3. Report any issues on GitHub
4. Share your experience
5. Consider contributing improvements

---

**Good luck with your deployment! 🚀**

If you encounter issues, check SETUP_GUIDE.md for detailed troubleshooting.
