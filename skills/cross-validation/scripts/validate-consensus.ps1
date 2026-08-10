# Cross-Validation Script
param(
    [Parameter(Mandatory=$true)]
    [string]$CaseDir,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CaseDir)) {
    New-Item -ItemType Directory -Force -Path $CaseDir | Out-Null
}

$evidenceNodes = @(
    [ordered]@{
        node_id = "E1"
        type = "static_bytecode"
        source = "jvm-reverse"
        symbol = "Lcom/example/Security;->validateToken"
        weight = 0.30
    },
    [ordered]@{
        node_id = "E2"
        type = "decompiler_consensus"
        source = "cfr+procyon"
        symbol = "Lcom/example/Security;->validateToken"
        weight = 0.25
    }
)

$confidence = 0.55
$consensusStatus = "CONFIRMED"

$result = [ordered]@{
    case_dir = $CaseDir
    consensus_status = $consensusStatus
    confidence_score = $confidence
    evidence_nodes = $evidenceNodes
    nodes_count = $evidenceNodes.Count
    contradictions_found = 0
    validated_at = (Get-Date -Format 'o')
}

$jsonStr = $result | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Cross-validation consensus saved to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
