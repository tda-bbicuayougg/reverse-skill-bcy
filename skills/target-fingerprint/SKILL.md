---
name: target-fingerprint
description: Fingerprints binary, archive, source, and runtime artifacts to extract platform, architecture, runtime, framework, obfuscation indicators, and confidence score before planning analysis workflows.
---

# Target Fingerprint Engine

Standardized fingerprinting engine for `reverse-skill-bcy`. Fingerprinting runs prior to workflow planning to prevent routing errors and tool mismatches.

## Capabilities

- **Artifact Identification**: Computes SHA-256, format, size, and entropy.
- **Platform & Architecture Detection**: Detects Windows, Linux, macOS, Android, JVM, CLR, WASM, ARM, x86/x64.
- **Runtime & Language Analysis**: Recognizes Java, Kotlin, Go, Rust, .NET, Node/V8, Native C/C++.
- **Framework Discovery**: Identifies Fabric, Forge, NeoForge, Unity, Electron, Qt, Spring.
- **Obfuscation Indicator Extraction**: Detects name obfuscation, string encryption, control-flow flattening, packing, custom class loading.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/target-fingerprint/scripts/fingerprint.ps1 -TargetPath "<file_or_directory>" -OutFile "fingerprint.json"
```

## Schema Output

Outputs a JSON file adhering to `schemas/fingerprint.schema.json`.
