# JVM JAR Analysis Script
param(
    [Parameter(Mandatory=$true)]
    [string]$JarPath,
    [string]$OutDir = "work/jvm-analysis"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $JarPath)) {
    Write-Error "JAR file not found: $JarPath"
    exit 1
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

Write-Host "[*] Extracting JAR inventory for $JarPath..." -ForegroundColor Green

Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($JarPath)

$classCount = 0
$resourceCount = 0
$manifestFound = $false
$classes = @()

foreach ($entry in $zip.Entries) {
    if ($entry.FullName.EndsWith(".class")) {
        $classCount++
        $classes += $entry.FullName
    } elseif ($entry.FullName -eq "META-INF/MANIFEST.MF") {
        $manifestFound = $true
    } else {
        $resourceCount++
    }
}
$zip.Dispose()

$summary = [ordered]@{
    jar_path = $JarPath
    total_classes = $classCount
    total_resources = $resourceCount
    has_manifest = $manifestFound
    sample_classes = ($classes | Select-Object -First 10)
    decompiler_recommended = "cfr"
}

$summaryPath = Join-Path $OutDir "inventory.json"
$summary | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $summaryPath -Encoding UTF8

Write-Host "[+] JAR Inventory completed. Classes: $classCount, Resources: $resourceCount" -ForegroundColor Green
Write-Host "[+] Summary saved to $summaryPath" -ForegroundColor Green
