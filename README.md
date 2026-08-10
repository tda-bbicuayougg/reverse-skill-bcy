<p align="center">
  <img src="" alt="reverse-skill-bcy" width="140" />
</p>

<h1 align="center">reverse-skill-bcy</h1>
<h3 align="center">Cybersecurity Skills Router & AI Reverse Engineering Workbench · bbicuayou Edition</h3>

<p align="center"><em style="font-family: Georgia, serif; font-size: 1.2em; color: #777;">Navigate the dark waters, sail against the stream.</em></p>

<p align="center">
  <a href="https://github.com/tda-bbicuayougg/reverse-skill-bcy/releases"><img src="https://img.shields.io/badge/release-v1.0.1-blue" alt="release v1.0.1"></a>
  <a href="https://github.com/tda-bbicuayougg/reverse-skill-bcy/stargazers"><img src="https://img.shields.io/github/stars/tda-bbicuayougg/reverse-skill-bcy?style=flat&logo=github" alt="stars"></a>
  <a href="https://github.com/tda-bbicuayougg/reverse-skill-bcy/forks"><img src="https://img.shields.io/github/forks/tda-bbicuayougg/reverse-skill-bcy?style=flat&logo=github" alt="forks"></a>
  <a href="https://github.com/tda-bbicuayougg/reverse-skill-bcy/issues"><img src="https://img.shields.io/github/issues/tda-bbicuayougg/reverse-skill-bcy?style=flat&logo=github" alt="issues"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="license"></a>
  <a href="CHANGELOG.md"><img src="https://img.shields.io/badge/changelog-Keep%20a%20Changelog-orange" alt="changelog"></a>
</p>

<br/>
<p align="center">
  <a href="#about">About</a> ·
  <a href="#getting-started">Getting Started</a> ·
  <a href="#workbench-architecture">Workbench Architecture</a> ·
  <a href="#skills-matrix">Skills Matrix</a> ·
  <a href="#usage">Usage</a> ·
  <a href="skills/MASTER-ROUTING.md">Fast Route</a> ·
  <a href="skills/routing.md">Routing Matrix</a> ·
  <a href="README_AI.md">AI Bootstrap</a>
</p>

<p align="center">
  🌐 <a href="README_zh.md">中文文档</a> ·
  <a href="https://github.com/tda-bbicuayougg/reverse-skill-bcy">Project Repository</a>
</p>

<br/>

<a id="about"></a>

## About

> **If you are an AI Agent (Claude Code, Cursor, Codex, OpenCode, Antigravity), jump to [README_AI.md](README_AI.md) and follow the instructions strictly.**

**reverse-skill-bcy** is a platform-neutral **Cybersecurity Skills Router and AI Reverse Engineering Workbench** maintained by **bbicuayou (bcy)**. 

When an AI Agent encounters an APK, a binary, frontend JS encryption, a CTF challenge, a pentesting target, or a complex security investigation, **reverse-skill-bcy** automatically routes the task to the right methodology, checks installed tools, and executes a repeatable, evidence-backed workflow instead of guessing shell commands.

```text
User Task
  ↓
RULES.md & Scope Control Plane (auth.status=granted required before ACT)
  ↓
Target Fingerprint Engine (File format, Arch, Platform, Obfuscation, Runtime)
  ↓
Analysis Planner (DAG Workflow Generation)
  ↓
Master Routing / master-route.ps1 (48 Route Rules: R0–R48)
  ↓
Specialist Skill → Toolchain / MCP / Scripts (50 Skill Modules)
  ↓
Deobfuscation Safety Engine (Immutable Snapshots & Rollback)
  ↓
Evidence Cross-Validation & Confidence Engine (Consensus Scoring)
  ↓
Evidence Graph → Formal Report & Field Journal
```

### Key Capabilities

- **Automated Skill Routing**: 48 deterministic routing rules (R0–R48) backed by 171 benchmark regression tests.
- **AI Reverse Engineering Workbench**: Target fingerprinting, DAG planning, JVM/JAR bytecode analysis, deobfuscation pass engine with immutable snapshots, and evidence cross-validation.
- **Security Assessment Platform**: Scope control plane, asset registry, attack surface graph modeling, vulnerability hypothesis validation, and cross-domain correlation (Mobile → API → Identity → Cloud).
- **Client-Neutral Design**: Works seamlessly with Claude Code, Cursor, Codex, OpenCode, Antigravity, or custom AI clients.

### Repository Status

| Routing Rules | Benchmark Suite | Core Skill Modules | Platform Support | Client Adapter |
|:---:|:---:|:---:|:---:|:---:|
| 48 (R0–R48) | 171 Test Cases | 50 Active Modules | Windows + Linux + Kali | Client-Neutral |

<br/>

<a id="getting-started"></a>

## Getting Started

### Prerequisites

- **Java JDK 17+ / 21+** — for jadx, apktool, and CFR/Vineflower decompiler adapters
- **Node.js 22.12+** — for JS toolchain, Playwright, and MCP servers
- **Python 3.10+** — for Frida, pwntools, and helper scripts
- **PowerShell 5.1+ / pwsh 7+** — for Windows and cross-platform orchestration

### Installation

```bash
git clone https://github.com/tda-bbicuayougg/reverse-skill-bcy.git
cd reverse-skill-bcy
```

### Quick Initialization

Run the one-shot initializer script for **bbicuayou Edition**:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File init-bcy.ps1
```

Refresh local tool availability index per platform:

| Platform | Command |
|---|---|
| Windows | `powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/refresh-tool-index.ps1` |
| Linux / macOS | `bash skills/scripts/refresh-tool-index.sh` |
| Kali Linux | `bash kali/scripts/refresh-tool-index.sh` |

Check [skills/tool-index.md](skills/tool-index.md) to inspect detected tools on your machine.

<br/>

<a id="workbench-architecture"></a>

## Workbench Architecture

```text
                               SECURITY ASSESSMENT CORE
                                          │
                     ┌────────────────────┼────────────────────┐
                     │                    │                    │
                  SCOPE                TARGET               PLANNER
                     │                    │                    │
                     └────────────────────┼────────────────────┘
                                          │
                                          ▼
                                 ATTACK SURFACE GRAPH
                                          │
                                          ▼
                                 DOMAIN SELECTION
                                          │
        ┌───────────────┬─────────┼──────────┬───────────────┐
        │               │         │          │               │
       WEB             API      MOBILE     CLOUD          FIRMWARE
        │               │         │          │               │
        ├───────────────┼─────────┼──────────┼───────────────┤
        │               │         │          │               │
     IDENTITY       CONTAINER    AI/LLM   SUPPLY CHAIN      PWN
        │               │         │          │               │
        └───────────────┴─────────┼──────────┴───────────────┘
                                          │
                                          ▼
                                 HYPOTHESIS ENGINE
                                          │
                                          ▼
                                 VALIDATION ENGINE
                                          │
                                          ▼
                                   EVIDENCE GRAPH
                                          │
                                          ▼
                                    FINDING ENGINE
                                          │
                                          ▼
                                   KNOWLEDGE BASE
```

### Core Workbench Engines

1. **Target Fingerprinting Engine (`skills/target-fingerprint/`)**: Extracts SHA256, format, architecture, runtime, framework, obfuscation markers, and confidence score.
2. **Analysis Planner (`skills/analysis-planner/`)**: Constructs dependent DAG workflow plans based on target fingerprints.
3. **JVM / JAR Reverse Engine (`skills/jvm-reverse/`)**: Analyzes Java/Kotlin bytecode, Constant Pool, `invokedynamic`, reflection calls, and orchestrates CFR/Vineflower decompilers.
4. **Deobfuscation Safety Engine (`skills/deobfuscation/`)**: Manages deobfuscation passes with immutable input snapshots (`snapshots/original/`) and automatic rollback.
5. **Cross-Validation Engine (`skills/cross-validation/`)**: Compares findings across decompilers/disassemblers (IDA, Ghidra, r2, CFR), flags `UNCERTAIN` on contradictions, and computes consensus confidence.
6. **Scope Control Plane (`core/assessment/`)**: Real-time authorization enforcement (`ALLOW`, `DENY`, `REQUIRE_APPROVAL`).

<br/>

<a id="skills-matrix"></a>

## Skills Matrix

`reverse-skill-bcy` includes **50 core skill modules** organized by domain:

### 1. Reverse Engineering & Binary Analysis

| Skill | Path | Description |
|---|---|---|
| **apk-reverse** | [skills/apk-reverse/](skills/apk-reverse/SKILL.md) | Android APK unpacking, Java decompilation, smali patching, Frida hooking, native `.so` analysis. |
| **mobile-reverse** | [skills/mobile-reverse/](skills/mobile-reverse/SKILL.md) | Android & iOS runtime analysis, SSL pinning bypass, root/jailbreak detection bypass. |
| **ida-reverse** | [skills/ida-reverse/](skills/ida-reverse/SKILL.md) | IDA Pro reverse engineering, decompilation, cross-references, and data flow analysis. |
| **ghidra-reverse** | [skills/ghidra-reverse/](skills/ghidra-reverse/SKILL.md) | Open-source reverse engineering with Ghidra (headless & GUI). |
| **radare2** | [skills/radare2/](skills/radare2/SKILL.md) | Command-line binary disassembly, inspection, and patching with radare2 / r2. |
| **dotnet-reverse** | [skills/dotnet-reverse/](skills/dotnet-reverse/SKILL.md) | .NET / C# PE reversing, NativeAOT, ConfuserEx deobfuscation, IL patching. |
| **go-rust-reverse** | [skills/go-rust-reverse/](skills/go-rust-reverse/SKILL.md) | Stripped Go and Rust binary analysis, `pclntab`, module data, and panic string recovery. |
| **jvm-reverse** | [skills/jvm-reverse/](skills/jvm-reverse/SKILL.md) | JVM bytecode intelligence, Constant Pool, `invokedynamic`, CFR/Vineflower decompiler orchestration. |
| **target-fingerprint**| [skills/target-fingerprint/](skills/target-fingerprint/SKILL.md) | Automated target fingerprinting (format, arch, platform, obfuscation, confidence). |
| **deobfuscation** | [skills/deobfuscation/](skills/deobfuscation/SKILL.md) | Safe deobfuscation pass engine with immutable input snapshotting and rollback. |
| **cross-validation** | [skills/cross-validation/](skills/cross-validation/SKILL.md) | Multi-tool consensus validation, contradiction resolution, and evidence graph linking. |
| **js-reverse** | [skills/js-reverse/](skills/js-reverse/SKILL.md) | Frontend JS signature reverse engineering, CDP, JSHook, AST, SourceMap recovery. |
| **dsl-vm-reverse** | [skills/reverse-engineering/dsl-vm-reverse/](skills/reverse-engineering/dsl-vm-reverse/SKILL.md) | Custom JS/WASM opcode interpreter and risk-control VM reverse engineering. |
| **browser-extension**| [skills/browser-extension-reverse/](skills/browser-extension-reverse/SKILL.md) | Chrome/Firefox extension analysis, MV3 background workers, permission review. |
| **binary-diff** | [skills/binary-diff/](skills/binary-diff/SKILL.md) | Cross-version binary diffing and symbol migration. |
| **macos-reverse** | [skills/macos-reverse/](skills/macos-reverse/SKILL.md) | macOS Mach-O reversing, codesign analysis, Obj-C/Swift metadata recovery. |

### 2. Exploit Development & Pentesting

| Skill | Path | Description |
|---|---|---|
| **pwn-chain** | [skills/pwn-chain/](skills/pwn-chain/SKILL.md) | Full-stack binary exploit engineering (Stack/Heap overflow, ROP, kernel pwn). |
| **edr-bypass-re** | [skills/edr-bypass-re/](skills/edr-bypass-re/SKILL.md) | EDR/AV hook table reversing, direct syscalls, AMSI/ETW patching. |
| **patch-diff-exploit**| [skills/patch-diff-exploit/](skills/patch-diff-exploit/SKILL.md) | N-day vendor patch diffing, vulnerability root-cause analysis, PoC creation. |
| **pentest-tools** | [skills/pentest-tools/](skills/pentest-tools/SKILL.md) | Active pentesting toolchain (Nmap, Nuclei, SQLMap, FFUF, Hashcat, Hydra). |
| **src-hunter** | [skills/pentest-tools/src-hunter/](skills/pentest-tools/src-hunter/SKILL.md) | Real-world SRC / Bug Bounty workflow with 19 attack playbooks. |
| **attack-chain** | [skills/attack-chain/](skills/attack-chain/SKILL.md) | Multi-stage attack path planning (Recon → Access → PrivEsc → Lateral Movement). |
| **windows-ad** | [skills/windows-ad/](skills/windows-ad/SKILL.md) | Active Directory & Windows Identity security (Kerberos, AD CS, BloodHound). |
| **security-assessment**| [skills/security-assessment/](skills/security-assessment/SKILL.md) | Security Assessment Platform master orchestrator. |
| **attack-surface-graph**| [skills/attack-surface-graph/](skills/attack-surface-graph/SKILL.md) | Directed attack surface graph visualization and path querying. |
| **hypothesis-validator**| [skills/hypothesis-validator/](skills/hypothesis-validator/SKILL.md) | Vulnerability hypothesis formulation and disproof testing. |

### 3. Specialized Security Domains

| Skill | Path | Description |
|---|---|---|
| **cloud-k8s** | [skills/cloud-k8s/](skills/cloud-k8s/SKILL.md) | Cloud, container, and Kubernetes security (Metadata SSRF, IAM, container escape). |
| **api-security** | [skills/api-security/](skills/api-security/SKILL.md) | REST, GraphQL, WebSocket, and SOAP API security assessment (BOLA, JWT attacks). |
| **code-audit** | [skills/code-audit/](skills/code-audit/SKILL.md) | Source-code security review (SAST) using Semgrep and CodeQL patterns. |
| **malware-analysis** | [skills/malware-analysis/](skills/malware-analysis/SKILL.md) | Malware analysis (Static, Dynamic, YARA rules, IOC extraction, anti-analysis). |
| **firmware-pentest** | [skills/firmware-pentest/](skills/firmware-pentest/SKILL.md) | Firmware & IoT pentesting (Unpacking, EMBA, QEMU emulation, firmware exploits). |
| **hardware-security**| [skills/hardware-security/](skills/hardware-security/SKILL.md) | Embedded hardware interface security (UART, JTAG, SWD, debug pads). |
| **radio-sdr** | [skills/radio-sdr/](skills/radio-sdr/SKILL.md) | RF & Software Defined Radio research (HackRF, GNU Radio, wireless protocols). |
| **wifi-wireless** | [skills/wifi-wireless/](skills/wifi-wireless/SKILL.md) | Wi-Fi wireless security assessment (Handshake capture, Rogue AP research). |
| **ot-ics** | [skills/ot-ics/](skills/ot-ics/SKILL.md) | Industrial control systems security (PLC, SCADA, Purdue model, OT protocols). |
| **llm-security** | [skills/llm-security/](skills/llm-security/SKILL.md) | LLM application & AI Agent security (Prompt injection, RAG exposure, Tool abuse). |
| **supply-chain** | [skills/supply-chain-security/](skills/supply-chain-security/SKILL.md) | Software supply-chain security (SBOM, SCA, CI/CD pipeline integrity). |

### 4. CTF Sandbox Orchestrator

- Located in `CTF-Sandbox-Orchestrator/`: Features **42 specialized sub-skills** for CTF competition scenarios (Crypto, Reverse Pwn, Forensic Timeline, Kernel Escape, Windows Pivot, Stego, Web Runtime, etc.).

<br/>

<a id="usage"></a>

## Usage & Testing

### Regression Test Suite

Run the full cross-platform regression test suite after making changes:

```powershell
# 1. Routing regression benchmark (171 test cases)
powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/test-routing.ps1

# 2. Coherence and supply-chain pin gate check
powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/verify-routing-coherence.ps1

# 3. Documentation fact table verification
powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/verify-doc-facts.ps1

# 4. Smoke test (Verify + Script Parse + Quick Route)
powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/smoke.ps1

# 5. Check INDEX.md drift
powershell -NoProfile -ExecutionPolicy Bypass -File skills/scripts/extract-summaries.ps1 -Check
```

All 5 test scripts run automatically on **Windows + Ubuntu** via GitHub Actions CI for every push and pull request.

<br/>

## Key Files Summary

| File | Description |
|---|---|
| [README_AI.md](README_AI.md) | AI Agent bootstrap and configuration rules |
| [RULES.md](RULES.md) | Global execution rules & Scope authorization gates |
| [init-bcy.ps1](init-bcy.ps1) | One-shot initializer script for **bbicuayou Edition** |
| [skills/config/routing.json](skills/config/routing.json) | **Single Source of Truth** for 48 routing rules (R0–R48) |
| [skills/INDEX.md](skills/INDEX.md) | Auto-generated skill navigation index (50 modules) |
| [skills/tool-index.md](skills/tool-index.md) | Local tool availability status |
| [skills/MASTER-ROUTING.md](skills/MASTER-ROUTING.md) | PRIMARY fast routing ladder |
| [schemas/](schemas/) | JSON Schemas for Artifact, Fingerprint, Asset, Evidence, Finding, Risk |

<br/>

## License & Author

- **Author / Maintainer:** **tda-bbicuayougg (bbicuayou / bcy)**
- **Primary License:** **MIT License** (see [LICENSE](LICENSE)).
- **CTF-Sandbox-Orchestrator Component:** **GNU GPLv3**

<p align="right">(<a href="#about">back to top</a>)</p>
