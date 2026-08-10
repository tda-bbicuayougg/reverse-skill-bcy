# Target Fingerprint Script
param(
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $TargetPath)) {
    Write-Error "Target path does not exist: $TargetPath"
    exit 1
}

$fileItem = Get-Item -LiteralPath $TargetPath
$isDir = $fileItem.PSIsContainer

$size = 0
$sha256 = "0000000000000000000000000000000000000000000000000000000000000000"
if (-not $isDir) {
    $size = $fileItem.Length
    $sha256 = (Get-FileHash -LiteralPath $TargetPath -Algorithm SHA256).Hash.ToLower()
}

$ext = $fileItem.Extension.ToLower().TrimStart('.')
if ($isDir) { $ext = "directory" }

$platform = "unknown"
$arch = "unknown"
$runtimeName = "unknown"
$languages = @()
$frameworks = @()
$obfuscated = $false
$obfFamilies = @()

switch ($ext) {
    "jar" {
        $platform = "jvm"
        $runtimeName = "java"
        $languages += "java"
        # Check if zip contains fabric/forge metadata
        try {
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $zip = [System.IO.Compression.ZipFile]::OpenRead($TargetPath)
            foreach ($entry in $zip.Entries) {
                if ($entry.FullName -eq "fabric.mod.json") { $frameworks += "fabric" }
                if ($entry.FullName -eq "mcmod.info" -or $entry.FullName -match "META-INF/mods.toml") { $frameworks += "forge" }
                if ($entry.FullName -match "^[a-z]\.class$") {
                    $obfuscated = $true
                    if ("name-obfuscation" -notin $obfFamilies) { $obfFamilies += "name-obfuscation" }
                }
            }
            $zip.Dispose()
        } catch {}
    }
    "apk" {
        $platform = "android"
        $runtimeName = "dalvik/art"
        $languages += "java"
        $languages += "smali"
    }
    "exe" {
        $platform = "windows"
        $arch = "x64"
        $runtimeName = "native"
    }
    "dll" {
        $platform = "windows"
        $runtimeName = "native"
    }
    "so" {
        $platform = "linux"
        $runtimeName = "native"
    }
    default {
        $platform = "generic"
    }
}

$result = [ordered]@{
    artifact = [ordered]@{
        path = $TargetPath
        sha256 = $sha256
        size = $size
        format = $ext
    }
    platform = $platform
    architecture = $arch
    runtime = [ordered]@{
        name = $runtimeName
        version = $null
    }
    languages = $languages
    frameworks = $frameworks
    versions = [ordered]@{
        application = $null
        framework = $null
        mapping = $null
    }
    obfuscation = [ordered]@{
        detected = $obfuscated
        families = $obfFamilies
    }
    confidence = 0.90
}

$jsonStr = $result | ConvertTo-Json -Depth 5
if ($OutFile) {
    $jsonStr | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "[+] Fingerprint written to $OutFile" -ForegroundColor Green
} else {
    Write-Output $jsonStr
}
