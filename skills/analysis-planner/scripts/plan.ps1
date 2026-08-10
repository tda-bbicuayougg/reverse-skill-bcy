# Analysis Planner Script
param(
    [Parameter(Mandatory=$true)]
    [string]$FingerprintFile,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $FingerprintFile)) {
    Write-Error "Fingerprint file not found: $FingerprintFile"
    exit 1
}

$fp = Get-Content -LiteralPath $FingerprintFile -Raw -Encoding UTF8 | ConvertFrom-Json

$steps = @()

# Step 1: Inventory
$steps += [ordered]@{
    id = "step-01-inventory"
    name = "Artifact Inventory"
    skill = "target-fingerprint"
    prerequisites = @()
    cost = "low"
    expected_value = "high"
}

# Step 2: Static Analysis
if ($fp.platform -eq "jvm") {
    $steps += [ordered]@{
        id = "step-02-static-jvm"
        name = "JVM Bytecode & Decompilation"
        skill = "jvm-reverse"
        prerequisites = @("step-01-inventory")
        cost = "medium"
        expected_value = "high"
    }
} elseif ($fp.platform -eq "android") {
    $steps += [ordered]@{
        id = "step-02-static-android"
        name = "APK Decompilation & Static Triage"
        skill = "apk-reverse"
        prerequisites = @("step-01-inventory")
        cost = "medium"
        expected_value = "high"
    }
} else {
    $steps += [ordered]@{
        id = "step-02-static-binary"
        name = "Binary Disassembly & Static Triage"
        skill = "ida-reverse"
        prerequisites = @("step-01-inventory")
        cost = "high"
        expected_value = "high"
    }
}

# Step 3: Deobfuscation (if needed)
if ($fp.obfuscation.detected) {
    $steps += [ordered]@{
        id = "step-03-deobfuscate"
        name = "Deobfuscation Safety Pass"
        skill = "deobfuscation"
        prerequisites = @("step-02-static-jvm")
        cost = "medium"
        expected_value = "high"
    }
}

# Step 4: Cross Validation
$steps += [ordered]@{
    id = "step-04-cross-validation"
    name = "Evidence Cross-Validation"
    skill = "cross-validation"
    prerequisites = @($steps[-1].id)
    cost = "low"
    expected_value = "high"
}

$plan = [ordered]@{
    target = $fp.artifact.path
    fingerprint_hash = $fp.artifact.sha256
    dag_steps = $steps
    total_steps = $steps.Count
    generated_at = (Get-Date -Format 'o')
}

$jsonStr = $plan | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Analysis plan written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
