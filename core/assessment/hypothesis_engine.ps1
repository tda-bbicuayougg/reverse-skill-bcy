# Vulnerability Hypothesis Engine
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$ObservationSignal = "",
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CaseDir)) {
    New-Item -ItemType Directory -Force -Path $CaseDir | Out-Null
}

$hypotheses = @(
    [ordered]@{
        hypothesis_id = "H-001"
        suspected_vulnerability = "Broken Object Level Authorization (BOLA)"
        affected_asset_id = "A-002"
        supporting_observations = @($ObservationSignal, "Parameter user_id observed in API request")
        test_plan = [ordered]@{
            validation_command = "curl -H 'Authorization: Bearer TokenB' https://target.local/api/v1/user/1001"
            disproof_criteria = "HTTP 403 Forbidden returned"
        }
        status = "CANDIDATE"
        confidence = 0.70
    }
)

$result = [ordered]@{
    case_dir = $CaseDir
    total_hypotheses = $hypotheses.Count
    hypotheses = $hypotheses
    timestamp = (Get-Date -Format 'o')
}

$jsonStr = $result | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Hypothesis Registry written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
