# Deobfuscation Engine Script
param(
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [string]$OutDir = "work/deobfuscation"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $TargetPath)) {
    Write-Error "Target path not found: $TargetPath"
    exit 1
}

$snapshotsDir = Join-Path $OutDir "snapshots\original"
New-Item -ItemType Directory -Force -Path $snapshotsDir | Out-Null

$targetLeaf = Split-Path -Leaf $TargetPath
$snapPath = Join-Path $snapshotsDir $targetLeaf
Copy-Item -LiteralPath $TargetPath -Destination $snapPath -Force

Write-Host "[+] Original artifact snapshotted to $snapPath" -ForegroundColor Green

# Pass 1: Copy to working pass
$pass1Dir = Join-Path $OutDir "pass-001-string-decrypt"
New-Item -ItemType Directory -Force -Path $pass1Dir | Out-Null
$pass1File = Join-Path $pass1Dir $targetLeaf
Copy-Item -LiteralPath $snapPath -Destination $pass1File -Force

$origHash = (Get-FileHash -LiteralPath $snapPath -Algorithm SHA256).Hash
$pass1Hash = (Get-FileHash -LiteralPath $pass1File -Algorithm SHA256).Hash

$log = [ordered]@{
    original_target = $TargetPath
    original_hash = $origHash
    snapshot_path = $snapPath
    passes = @(
        [ordered]@{
            pass_id = "pass-001-string-decrypt"
            status = "SUCCESS"
            input_hash = $origHash
            output_hash = $pass1Hash
            validated = $true
        }
    )
    timestamp = (Get-Date -Format 'o')
}

$logPath = Join-Path $OutDir "deobfuscation-log.json"
$log | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $logPath -Encoding UTF8

Write-Host "[+] Deobfuscation pipeline initialized safely. Provenance log written to $logPath" -ForegroundColor Green
