# Hypothesis Validator Script
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

& powershell -NoProfile -ExecutionPolicy Bypass -File "core/assessment/hypothesis_engine.ps1" -CaseDir $CaseDir -OutFile $OutFile
