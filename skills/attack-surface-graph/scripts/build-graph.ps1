# Attack Surface Graph Builder Script
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/attack_surface_graph.ps1" -CaseDir $CaseDir -OutFile $OutFile
