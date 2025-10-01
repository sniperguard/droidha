# Quick Start Guide

## 🚀 Deploy in 5 Minutes

### Step 1: Update Your Info
Edit `repository.yaml`:
```yaml
name: Droid Terminal for Home Assistant
url: https://github.com/YOUR_USERNAME/droidha
maintainer: Your Name <your.email@example.com>
```

### Step 2: Push to GitHub
```bash
cd /Users/marcel/Development/droidha

git init
git add .
git commit -m "Initial commit: Droid Terminal add-on for Home Assistant"

# Create a new public repository on GitHub named "droidha"
# Then run:
git remote add origin https://github.com/YOUR_USERNAME/droidha.git
git branch -M main
git push -u origin main
```

### Step 3: Add to Home Assistant
1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click **⋮** (menu) → **Repositories**
4. Add: `https://github.com/YOUR_USERNAME/droidha`
5. Find "Droid Terminal" and click **Install**
6. Click **Start**
7. Click **Open Web UI**

### Step 4: Authenticate
1. Follow the OAuth flow when prompted
2. Sign in with your Factory account
3. Start using Droid!

## 📋 What You Get

- ✅ Web terminal in Home Assistant sidebar
- ✅ Droid CLI pre-installed and ready
- ✅ Access to your Home Assistant config files
- ✅ Persistent authentication
- ✅ Multi-architecture support

## 🔧 Configuration

Access **Configuration** tab in the add-on:

```yaml
auto_launch_droid: true  # Set to false for session picker
```

## 🎯 Key Differences from claude-terminal

This addon uses **completely different identifiers**:

| What | Value |
|------|-------|
| Slug | `droid_terminal` |
| Port | 7682 |
| Icon | `mdi:robot-industrial` |
| Config | `/data/.config/droid` |
| Package | `@factory-ai/droid` |

**No conflicts** if you have both addons installed!

## 📚 Documentation

- **SETUP_GUIDE.md** - Detailed setup and troubleshooting
- **PROJECT_SUMMARY.md** - Technical overview
- **droid-terminal/DOCS.md** - User documentation

## ⚠️ Important Notes

1. Repository must be **public** on GitHub
2. Update the repository URL in `repository.yaml` before pushing
3. The addon installs `@factory-ai/droid@latest` - update Dockerfile if you need a specific version
4. Authentication tokens are stored in `/data/.config/droid`

## 🐛 Common Issues

**Add-on won't start:**
- Check logs in the add-on Log tab
- Verify npm can reach the registry
- Wait a few minutes and try again

**Can't find Droid package:**
- The Dockerfile tries to install `@factory-ai/droid@latest`
- If this package name is incorrect, update it in the Dockerfile
- Check Factory's documentation for the correct npm package name

**Authentication fails:**
- Verify your Factory account is active
- Check internet connectivity
- Try restarting the add-on

## 🆘 Need Help?

1. Check the **Log** tab in the add-on
2. Review SETUP_GUIDE.md for detailed troubleshooting
3. Create an issue on GitHub

## 📝 Next Steps

1. Test the addon locally if possible
2. Push to GitHub
3. Install in Home Assistant
4. Use Droid to automate your home!

---

**Happy Automating! 🎉**
