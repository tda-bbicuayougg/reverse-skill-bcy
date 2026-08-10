---
name: cross-validation
description: Normalizes and cross-validates findings across multiple disassemblers, decompilers, and runtime traces. Computes empirical confidence scores and builds traceable evidence graph links.
---

# Cross-Validation Engine

Reliability and evidence graph cross-validation engine for `reverse-skill-bcy`.

## Capabilities

- **Decompiler Consensus**: Compares symbol boundaries, control flow graphs, and decrypted constants across multiple tools (IDA, Ghidra, r2, CFR).
- **Contradiction Resolution**: Flags status as `UNCERTAIN` when decompilers disagree, avoiding unverified LLM hallucinations.
- **Empirical Confidence Scoring**: Computes confidence scores from verified evidence (+0.30 static, +0.25 bytecode, +0.20 tool consensus, -0.40 contradiction).
- **Traceable Evidence Graph**: Links every finding node back to exact method symbols, strings, bytecode instructions, or runtime logs.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/cross-validation/scripts/validate-consensus.ps1 -CaseDir "work/case-001" -OutFile "consensus.json"
```
