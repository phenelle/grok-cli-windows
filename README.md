# Grok CLI Easy Installation for Windows

This repository provides a simple PowerShell script to install **Grok CLI** (`@vibe-kit/grok-cli`) on Windows, even on a completely fresh ("vanilla") Windows 11 installation.

Grok CLI is a beautiful, interactive terminal client for xAI's Grok models.

## Quick Installation (One Command)

Open a **normal PowerShell window** (no administrator rights needed) and run this single command:

```powershell
Invoke-WebRequest -Uri "https://github.com/phenelle/grok-cli-windows/archive/refs/heads/main.zip" -OutFile "$env:TEMP\grok-main.zip"; Expand-Archive -Path "$env:TEMP\grok-main.zip" -DestinationPath "$env:TEMP" -Force; & "$env:TEMP\grok-cli-windows-main\install-grok-cli.ps1"
```


## After running the command:

The script will automatically install Node.js + npm if they are missing.

It will install Grok CLI globally.

It will ask you to paste your GROK_API_KEY (characters hidden for security)
The key will be saved permanently as a user environment variable (GROK_API_KEY)

## When the installation finishes:

Close the current PowerShell window
Open a new PowerShell window (normal, no admin needed)
Type grok and press Enter

You should see the beautiful Grok CLI interface with "Ask me anything...".


## How to Get Your GROK_API_KEY

You need a valid API key and some credits to use Grok CLI.

- Go to: https://console.x.ai/
- Sign in with your X (Twitter) account
- Select your team
- Go to the Billing section
- Create a new API key — it will start with xai_
- Copy this key and paste it when the installer asks for it

*Important – You need credits*
New teams start with 0 credits.
You must purchase some prepaid credits in the Billing section (even $5–$10 is enough to start).
Without credits, Grok CLI will show a "403 no credits" error.


## Troubleshooting
- "grok : The term 'grok' is not recognized" → Close and reopen PowerShell (new session required)
- "API key required" → Run the installation command again to set the key
- Error 403 no credits → Go to https://console.x.ai → Billing → add credits
- Other issues? Open an issue on this repository with the exact error message