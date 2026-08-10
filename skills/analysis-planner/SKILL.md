---
name: analysis-planner
description: Constructs an executable Directed Acyclic Graph (DAG) analysis workflow from a target fingerprint, validating step prerequisites, cost, value, and safety boundaries before execution.
---

# Analysis Planner Engine

Workflow planner engine for `reverse-skill-bcy`. Converts fingerprint metadata into a structured DAG plan rather than executing static linear routes.

## Capabilities

- **DAG Workflow Generation**: Generates dependent steps (Fingerprint -> Inventory -> Decompile/Disassemble -> Deobfuscate -> Validate -> Report).
- **Prerequisite Validation**: Ensures steps are only executed when required artifacts and static hypotheses are met.
- **Cost/Value Optimization**: Skips low-value high-cost dynamic execution unless required by static hypothesis.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/analysis-planner/scripts/plan.ps1 -FingerprintFile "fingerprint.json" -OutFile "plan.json"
```
