---
name: hypothesis-validator
description: Evaluates and validates vulnerability hypotheses against empirical test conditions and disproof criteria to eliminate false positives before confirming security findings.
---

# Vulnerability Hypothesis Validator Skill

Hypothesis validation skill for `reverse-skill-bcy`.

## Capabilities

- **Hypothesis Formulation**: Transforms raw scanner observations into verifiable hypotheses.
- **Disproof Testing**: Tests disproof criteria to filter out false positive signals.
- **Status Assignment**: Categorizes status as `CONFIRMED`, `REJECTED`, or `INCONCLUSIVE`.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/hypothesis-validator/scripts/validate-hypothesis.ps1 -CaseDir "work/assessment-001" -OutFile "hypotheses_validated.json"
```
