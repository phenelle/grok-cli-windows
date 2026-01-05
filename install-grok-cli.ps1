# Vérifie si on est en admin, sinon relance en admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Vérifie et installe Node.js (inclut NPM) via winget si absent
$nodeInstalled = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeInstalled) {
    Write-Host "Installation de Node.js via winget..." -ForegroundColor Green
    winget install --id OpenJS.NodeJS --scope machine --accept-package-agreements --accept-source-agreements
    # Rafraîchit le PATH après install Node
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Vérifie que NPM est bien là maintenant
$npmInstalled = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmInstalled) {
    Write-Host "Erreur : NPM n'est pas installé après Node.js. Vérifie ton install Winget." -ForegroundColor Red
    Exit
}

# Installe le bon Grok CLI globalement
Write-Host "Installation de Grok CLI (@vibe-kit/grok-cli)..." -ForegroundColor Green
npm install -g @vibe-kit/grok-cli

# Demande la clé API xAI et la définit comme variable d'environnement persistante
$apiKey = Read-Host "Entre ta clé API xAI (commence par 'xai_') "
if ($apiKey) {
    [Environment]::SetEnvironmentVariable("XAI_API_KEY", $apiKey, "User")
    Write-Host "Clé API définie avec succès !" -ForegroundColor Green
} else {
    Write-Host "Aucune clé fournie. Tu pourras la définir plus tard via [Environment]::SetEnvironmentVariable('XAI_API_KEY', 'ta-clé', 'User')" -ForegroundColor Yellow
}

# Rafraîchit le PATH final pour que Grok CLI soit accessible
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Teste si Grok CLI est installé
$grokInstalled = Get-Command grok -ErrorAction SilentlyContinue
if ($grokInstalled) {
    Write-Host "Installation réussie ! Ouvre un nouveau PowerShell et tape 'grok' pour démarrer." -ForegroundColor Green
    Write-Host "Important : Achète des credits API sur https://console.x.ai (sinon erreur 403 'no credits')." -ForegroundColor Yellow
} else {
    Write-Host "Erreur : Grok CLI n'est pas détecté. Vérifie le PATH ou relance PowerShell." -ForegroundColor Red
}