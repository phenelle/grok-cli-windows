# Grok CLI Easy Installation for Windows

This repository provides a simple PowerShell script that installs **Grok CLI** (the official `@vibe-kit/grok-cli`) on Windows — even on a completely fresh ("vanilla") Windows 11 installation with nothing pre-installed.

Grok CLI gives you a beautiful, interactive AI terminal powered by xAI's Grok models.

The script does everything automatically:
- Installs Node.js + npm (if missing)
- Installs the correct Grok CLI package globally
- Asks for your Grok API key and saves it **permanently** (persistent across reboots and new terminals)
- Makes the `grok` command available immediately

## Important Prerequisites (do this first!)

1. **Get a Grok API key**
   - Go to: https://console.x.ai/
   - Sign in with your X (Twitter) account
   - Create a new API key (it starts with `xai_`)
   - Copy it — you'll paste it during installation

2. **Buy API credits**
   - New accounts start with 0 credits
   - In the console, go to your team → Billing → purchase some prepaid credits (even $5–10 is enough to start)
   - Without credits you'll get a "403 no credits" error

## Super Easy Installation (One Command)

You don't need to download or clone anything manually.

1. Open **PowerShell as Administrator**  
   (Press Windows key → type "PowerShell" → right-click → "Run as administrator")

2. Copy and paste this single command, then press Enter:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/phenelle/grok-cli-windows/main/install-grok-cli.ps1" -OutFile "install-grok-cli.ps1"; .\install-grok-cli.ps1