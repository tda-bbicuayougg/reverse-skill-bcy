# Security Assessment Master Script
param(
    [Parameter(Mandatory=$true)]
    [string]$Target,
    [string]$OutDir = "work/assessment"
)

$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

Write-Host "[*] Executing Scope Control Plane check for $Target..." -ForegroundColor Green
& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/scope_control.ps1" -Target $Target

Write-Host "[*] Initializing Asset Registry..." -ForegroundColor Green
& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/asset_registry.ps1" -CaseDir $OutDir -OutFile "$OutDir/assets.json"

Write-Host "[*] Building Attack Surface Graph..." -ForegroundColor Green
& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/attack_surface_graph.ps1" -CaseDir $OutDir -OutFile "$OutDir/attack_surface.json"

Write-Host "[*] Initializing Hypothesis Engine..." -ForegroundColor Green
& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/hypothesis_engine.ps1" -CaseDir $OutDir -OutFile "$OutDir/hypotheses.json"

Write-Host "[+] Security Assessment initialized successfully at $OutDir" -ForegroundColor Green
