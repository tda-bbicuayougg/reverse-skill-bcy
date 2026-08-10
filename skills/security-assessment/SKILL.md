---
name: security-assessment
description: Master control skill for structured security assessments. Coordinates Scope Control, Asset Discovery, Attack Surface Graphing, Hypothesis Validation, Finding Lifecycle, and Cross-Domain Correlation.
---

# Security Assessment Platform Master Skill

Central Security Assessment Platform orchestrator for `reverse-skill-bcy`.

## Capabilities

- **Scope Control Plane**: Enforces runtime scope policies (`ALLOW`, `DENY`, `REQUIRE_APPROVAL`).
- **Asset & Surface Modeling**: Registers assets and builds directed attack surface graphs.
- **Hypothesis-Driven Testing**: Evaluates observations against test conditions to eliminate false positives.
- **Cross-Domain Correlation**: Links vulnerabilities across Web, API, Mobile, Cloud, Identity, K8s, and LLM domains.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/security-assessment/scripts/assess.ps1 -Target "target.local" -OutDir "work/assessment-001"
```
