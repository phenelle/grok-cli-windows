# Check if running as Administrator; if not, relaunch as admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Check and install Node.js (includes NPM) via winget if not present
$nodeInstalled = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeInstalled) {
    Write-Host "Installing Node.js via winget..." -ForegroundColor Green
    winget install --id OpenJS.NodeJS --scope machine --accept-package-agreements --accept-source-agreements
    # Refresh PATH after Node.js installation
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Verify that NPM is now available
$npmInstalled = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmInstalled) {
    Write-Host "Error: NPM is not installed after Node.js setup. Check your Winget installation." -ForegroundColor Red
    Exit
}

# Install the Grok CLI globally
Write-Host "Installing Grok CLI (@vibe-kit/grok-cli)..." -ForegroundColor Green
npm install -g @vibe-kit/grok-cli

# Prompt for xAI API key and set it as a persistent user environment variable
$apiKey = Read-Host "Enter your xAI API key (starts with 'xai_') "
if ($apiKey) {
    [Environment]::SetEnvironmentVariable("GROK_API_KEY", $apiKey, "User")
    Write-Host "API key successfully set as persistent environment variable!" -ForegroundColor Green
} else {
    Write-Host "No key provided. You can set it later with: [Environment]::SetEnvironmentVariable('GROK_API_KEY', 'your-key', 'User')" -ForegroundColor Yellow
}

# Refresh PATH for the current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Test if Grok CLI is installed
$grokInstalled = Get-Command grok -ErrorAction SilentlyContinue
if ($grokInstalled) {
    Write-Host "Installation successful!" -ForegroundColor Green
    Write-Host "IMPORTANT: Restart PowerShell (close and reopen a new window) before running 'grok' for the first time." -ForegroundColor Yellow
    Write-Host "This ensures the PATH and GROK_API_KEY environment variable are fully loaded." -ForegroundColor Yellow
    Write-Host "After restarting, simply type 'grok' to start the agent." -ForegroundColor Green
    Write-Host "Reminder: Purchase API credits at https://console.x.ai if needed (otherwise you may get a 403 'no credits' error)." -ForegroundColor Yellow
} else {
    Write-Host "Error: Grok CLI not detected. Check your PATH or restart PowerShell." -ForegroundColor Red
}