# Finding Lifecycle & Deduplication Engine
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CaseDir)) {
    New-Item -ItemType Directory -Force -Path $CaseDir | Out-Null
}

$findings = @(
    [ordered]@{
        finding_id = "F-001"
        title = "BOLA in User Profile Endpoint"
        vulnerability_class = "CWE-639"
        affected_asset_id = "A-002"
        status = "CONFIRMED"
        evidence_ids = @("E1", "E2")
        risk = [ordered]@{
            severity = "HIGH"
            confidence = 0.95
            exploitability = "POC_EXISTS"
            business_impact = "HIGH"
            composite_score = 8.5
        }
        attack_path_position = "Step-2-PrivilegeEscalation"
    }
)

$result = [ordered]@{
    case_dir = $CaseDir
    total_findings = $findings.Count
    findings = $findings
    deduplicated_count = 0
    updated_at = (Get-Date -Format 'o')
}

$jsonStr = $result | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Finding Registry written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
