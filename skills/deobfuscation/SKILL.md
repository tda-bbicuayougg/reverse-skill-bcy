---
name: deobfuscation
description: Deobfuscates obfuscated binaries, Java JARs, and scripts using a safe pass pipeline with immutable input snapshotting, transformation logging, and automatic rollback on validation failure.
---

# Deobfuscation Engine

Safe deobfuscation engine for `reverse-skill-bcy`. Protects original input artifacts while applying deobfuscation passes.

## Capabilities

- **Immutable Snapshots**: Stores original artifacts in `snapshots/original/` before any transformation pass.
- **Pass Selection**: Executes name un-flattening, string decryption, constant folding, and dead-code removal.
- **Pass Validation**: Verifies transformed artifacts after each pass and automatically rolls back if execution fails validation.
- **Transformation Provenance**: Logs parameters, tool versions, input/output hashes, and pass metadata.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/deobfuscation/scripts/deobfuscate.ps1 -TargetPath "target.jar" -OutDir "work/deobfuscated"
```
