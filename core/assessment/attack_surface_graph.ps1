# Attack Surface Graph Engine
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CaseDir)) {
    New-Item -ItemType Directory -Force -Path $CaseDir | Out-Null
}

$nodes = @(
    [ordered]@{ asset_id = "A-001"; type = "mobile_client"; value = "App.apk"; confidence = 1.0 },
    [ordered]@{ asset_id = "A-002"; type = "api_endpoint"; value = "/api/v1/auth"; confidence = 0.95 },
    [ordered]@{ asset_id = "A-003"; type = "identity"; value = "Role::Admin"; confidence = 0.90 }
)

$edges = @(
    [ordered]@{ source_id = "A-001"; target_id = "A-002"; relation = "CALLS"; confidence = 1.0 },
    [ordered]@{ source_id = "A-002"; target_id = "A-003"; relation = "AUTHENTICATES"; confidence = 0.90 }
)

$graph = [ordered]@{
    case_dir = $CaseDir
    nodes = $nodes
    edges = $edges
    trust_boundaries = @("Mobile-to-API", "API-to-Identity")
    updated_at = (Get-Date -Format 'o')
}

$jsonStr = $graph | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Attack Surface Graph written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
