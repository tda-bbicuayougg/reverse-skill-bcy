---
name: attack-surface-graph
description: Builds, visualizes, and queries directed attack surface graphs connecting assets, endpoints, identities, cloud resources, and trust boundaries across multiple security domains.
---

# Attack Surface Graph Skill

Attack surface graph modeling skill for `reverse-skill-bcy`.

## Capabilities

- **Multi-Asset Graph Construction**: Connects Mobile, Web, API, Identity, Cloud, and Container assets into a single directed graph.
- **Trust Boundary Identification**: Highlights boundaries across environments and authorization levels.
- **Path Querying**: Queries potential attack paths prior to active testing.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/attack-surface-graph/scripts/build-graph.ps1 -CaseDir "work/assessment-001" -OutFile "graph.json"
```
