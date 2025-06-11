# install.ps1 – Hedglab Warp Setup Bootstrapper
# Usage: Run from repo root with right-click → Run with PowerShell or: .\install.ps1

Write-Host "`n🚀 Installing Hedglab Warp Setup..." -ForegroundColor Cyan

# 1. Scoop Setup
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Scoop not found. Installing..." -ForegroundColor Yellow
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    iwr -useb get.scoop.sh | iex
} else {
    Write-Host "📦 Scoop already installed." -ForegroundColor Green
}

# 2. Install tools
$scoopTools = @("oh-my-posh", "lsd", "bat", "zoxide")
foreach ($tool in $scoopTools) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        Write-Host "📥 Installing $tool..." -ForegroundColor Yellow
        scoop install $tool
    } else {
        Write-Host "✅ $tool already installed." -ForegroundColor Green
    }
}

# 3. Ensure PowerShell config dir exists
$profileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# 4. Copy PowerShell profile
Copy-Item ".\powershell\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
Write-Host "🧠 PowerShell profile installed to: $PROFILE" -ForegroundColor Magenta

# 5. Copy Oh My Posh theme
$ompDest = "$env:LOCALAPPDATA\oh-my-posh\themes"
if (-not (Test-Path $ompDest)) {
    New-Item -ItemType Directory -Path $ompDest -Force | Out-Null
}
Copy-Item ".\oh-my-posh\hedglab.omp.json" -Destination "$ompDest\hedglab.omp.json" -Force
Write-Host "🎨 Oh My Posh theme installed to: $ompDest" -ForegroundColor Magenta

Write-Host "`n✅ Hedglab Warp setup complete! Restart Warp to apply changes." -ForegroundColor Cyan
