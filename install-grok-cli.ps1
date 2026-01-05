#Requires -Version 5.1

param()

# Fonction pour vérifier les privilèges administrateur
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -Verb RunAs -ArgumentList "-File `"$scriptPath`"" -Wait
    exit
}

# Vérifier si winget est disponible
try {
    $wingetVersion = & winget --version 2>$null
    Write-Host "Winget est disponible : $wingetVersion"
} catch {
    Write-Error "Winget est requis sur Windows 10/11. Veuillez l'installer depuis https://github.com/microsoft/winget-cli"
    exit 1
}

# Vérifier si Node.js est installé
try {
    $nodeVersion = & node --version 2>$null
    Write-Host "Node.js est installé : $nodeVersion"
} catch {
    Write-Host "Installation de Node.js LTS..."
    & winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
    # Actualiser le PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Installer Grok CLI via npm
& npm install -g grok-cli

# Demander la clé API
$apiKey = Read-Host "Entrez votre clé API Grok"
[Environment]::SetEnvironmentVariable("GROK_API_KEY", $apiKey, "User")

Write-Host "Installation terminée. Redémarrez votre terminal pour utiliser grok-cli."