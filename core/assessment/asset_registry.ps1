# Asset Registry Engine
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CaseDir)) {
    New-Item -ItemType Directory -Force -Path $CaseDir | Out-Null
}

$assets = @(
    [ordered]@{
        asset_id = "A-001"
        type = "domain"
        source = "recon"
        value = "target.local"
        confidence = 1.0
        in_scope = $true
        observed_at = (Get-Date -Format 'o')
    }
)

$registry = [ordered]@{
    case_dir = $CaseDir
    total_assets = $assets.Count
    assets = $assets
    updated_at = (Get-Date -Format 'o')
}

$jsonStr = $registry | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Asset Registry written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
