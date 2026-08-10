# ==============================================================================
# reverse-skill-bcy Initializer Script
# Author: tda-bbicuayougg (bbicuayou / bcy)
# ==============================================================================

Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "  __ reverse-skill-bcy __                                             " -ForegroundColor Cyan
Write-Host "  Cybersecurity Skills Router (bbicuayou / bcy Edition)               " -ForegroundColor Yellow
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host ""

$RootPath = $PSScriptRoot

Write-Host "[*] Refreshing tool index for current system..." -ForegroundColor Green
$RefreshScript = Join-Path $RootPath "skills\scripts\refresh-tool-index.ps1"
if (Test-Path $RefreshScript) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $RefreshScript
    Write-Host "[+] Tool index updated successfully." -ForegroundColor Green
} else {
    Write-Host "[!] Warning: refresh-tool-index.ps1 not found at $RefreshScript" -ForegroundColor Red
}

Write-Host ""
Write-Host "[*] Running smoke test..." -ForegroundColor Green
$SmokeScript = Join-Path $RootPath "skills\scripts\smoke.ps1"
if (Test-Path $SmokeScript) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $SmokeScript
    Write-Host "[+] Smoke test completed." -ForegroundColor Green
}

Write-Host ""
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host " [+] Environment initialized! reverse-skill-bcy is ready to use." -ForegroundColor Green
Write-Host " Repository: https://github.com/tda-bbicuayougg/reverse-skill-bcy.git" -ForegroundColor Yellow
Write-Host "======================================================================" -ForegroundColor Cyan
