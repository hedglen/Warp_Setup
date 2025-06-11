# ─────────────────────────────────────────────────────────────
# 💻 PowerShell Profile for Warp + DevLab Setup
# Location: C:\Users\Hedgl\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# Updated: 2025-06-11
# ─────────────────────────────────────────────────────────────


# ✅ UTF-8 output
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ✅ Scoop path
$env:PATH += ";$env:USERPROFILE\scoop\shims"

# ✅ Oh My Posh – custom theme
oh-my-posh init pwsh --config "C:\Users\Hedgl\AppData\Local\oh-my-posh\themes\hedglab.omp.json" | Invoke-Expression

# ✅ Welcome banner + quote
Write-Host "`n🚀 Warp Terminal Booted – Welcome to Hedglab.dev" -ForegroundColor Magenta

# 🧠 Quote of the moment
$quotes = @(
    "🔥 You’re not debugging. You’re time traveling.",
    "🧠 AI writes code. You write the future.",
    "👁️‍🗨️ The bug you ignore today spawns tech debt tomorrow.",
    "💡 Clarity comes not from code, but from thought before code.",
    "🧬 Refactor until it sings. Then refactor again."
)
Write-Host "`n$(Get-Random -InputObject $quotes)`n" -ForegroundColor Cyan

# ✅ Dev tools ready check
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Write-Host "📄 bat ready." -ForegroundColor Green
}
if (Get-Command lsd -ErrorAction SilentlyContinue) {
    Write-Host "📁 lsd ready." -ForegroundColor Green
}
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Write-Host "📂 zoxide ready." -ForegroundColor Green
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# ✅ Function override: cd → zoxide
function cd {
    z $args
}

# ✅ PSReadLine suggestions
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -Colors @{ "InlinePrediction" = "#5555FF" }

# ✅ System info block
Write-Host "`n🧠 Hedglab Dev. System uptime:" (Get-Uptime) "`n" -ForegroundColor Cyan
Get-PSDrive C | Select-Object Used, Free, @{Name='Usage (%)';Expression={[math]::Round($_.Used / ($_.Used + $_.Free) * 100, 1)}} | Format-List

# ✅ Cursor style for Warp
$host.UI.RawUI.CursorSize = 25

# ✅ Launch DevLab workspace in VS Code if not already open (optional)
# code "C:\Obsidian Vaults\DevLab"

# ✅ Winfetch
$esc = [char]27

function OrangeText($label, $value) {
  Write-Host "$esc[38;2;255;140;0m$label`e[0m $value"
}

OrangeText "Packages:" "-1 (choco), 4 (scoop)"
OrangeText "GPU:" "NVIDIA GeForce RTX 3070 Ti"
OrangeText "Disk (C:):" "731 GiB / 930 GiB (78%)"

winfetch
