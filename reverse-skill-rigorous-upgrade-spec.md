# Reverse-Skill — Rigorous Upgrade Specification

## 0. Mục tiêu

Mục tiêu của bản nâng cấp **không phải** là tăng số lượng skill một cách cơ học.

Mục tiêu là biến `reverse-skill` từ:

```text
Skill Router
```

thành:

```text
AI Reverse Engineering Workbench
```

có khả năng:

```text
Target
  ↓
Fingerprint
  ↓
Plan
  ↓
Static Analysis
  ↓
Deobfuscation
  ↓
Dynamic Analysis khi cần
  ↓
Cross-Validation
  ↓
Evidence Graph
  ↓
Confidence
  ↓
Report
  ↓
Knowledge Base
```

### Nguyên tắc cốt lõi

1. **Không rewrite routing core nếu không cần.**
2. **Không thêm skill chỉ để tăng số lượng.**
3. **Mọi kết luận quan trọng phải có evidence.**
4. **Decompiler output chỉ là hypothesis, không phải ground truth.**
5. **Không sửa artifact gốc.**
6. **Mọi transformation phải có snapshot và rollback.**
7. **Dynamic analysis được dùng để kiểm chứng hypothesis, không phải chạy vô điều kiện.**
8. **Knowledge Base chỉ học từ workflow/kết quả đã được validation.**
9. **Skill mới phải có regression test.**
10. **Mọi tool phải có capability detection và fallback.**
11. **Minecraft là specialization trên nền JVM, không phải một hệ thống tách biệt hoàn toàn.**
12. **Offensive capability phải có scope/authorization boundary rõ ràng.**

---

# 1. Trọng tâm nâng cấp

Phân bổ effort đề xuất:

| Hạng mục | Trọng tâm |
|---|---:|
| Core Reverse Engineering | 25% |
| JVM / JAR / Bytecode | 20% |
| Deobfuscation | 15% |
| Target Fingerprinting + Planner | 10% |
| Static/Dynamic Correlation | 10% |
| Evidence + Cross-Validation | 10% |
| Minecraft specialization | 5% |
| Knowledge Base / Self-improvement | 5% |

> **Lưu ý:** Minecraft không nên trở thành trung tâm của toàn bộ kiến trúc. Nó nên là một specialization sử dụng JVM engine chung.

---

# 2. Architecture mục tiêu

```text
                         USER
                           │
                           ▼
                ┌─────────────────────┐
                │   INTENT ANALYZER   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ TARGET FINGERPRINT  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ ANALYSIS PLANNER    │
                └──────────┬──────────┘
                           │
             ┌─────────────┼─────────────┐
             ▼             ▼             ▼
          STATIC        DYNAMIC        DIFF
          ENGINE         ENGINE        ENGINE
             │             │             │
             └─────────────┼─────────────┘
                           ▼
                ┌─────────────────────┐
                │ DEOBFUSCATION       │
                │ ENGINE              │
                └──────────┬──────────┘
                           ▼
                ┌─────────────────────┐
                │ CROSS VALIDATION    │
                └──────────┬──────────┘
                           ▼
                ┌─────────────────────┐
                │ EVIDENCE GRAPH      │
                └──────────┬──────────┘
                           ▼
                ┌─────────────────────┐
                │ CONFIDENCE ENGINE   │
                └──────────┬──────────┘
                           ▼
                ┌─────────────────────┐
                │ REPORT GENERATOR    │
                └──────────┬──────────┘
                           ▼
                ┌─────────────────────┐
                │ KNOWLEDGE BASE      │
                └─────────────────────┘
```

---

# 3. Phase 1 — Target Fingerprinting

## 3.1. Vì sao phải làm đầu tiên?

Nếu target được nhận diện sai:

```text
Wrong fingerprint
      ↓
Wrong skill
      ↓
Wrong tool
      ↓
Wrong analysis
      ↓
Wrong conclusion
```

Do đó fingerprint phải đứng trước workflow planning.

## 3.2. Fingerprint phải xác định

### Artifact

- file type
- size
- SHA-256
- entropy
- archive structure
- nested artifacts
- timestamps khi có ý nghĩa

### Platform

- Windows
- Linux
- macOS
- Android
- JVM
- CLR
- browser/runtime
- firmware

### Architecture

- x86
- x64
- ARM
- ARM64
- MIPS
- RISC-V
- JVM bytecode
- WASM

### Runtime

- Java
- Kotlin/JVM
- .NET
- Go
- Rust
- native
- Node/V8
- Python
- Android runtime

### Framework

Ví dụ:

- Fabric
- Forge
- NeoForge
- Unity
- Electron
- Qt
- .NET framework
- Android framework

### Obfuscation

Detect các family:

- name obfuscation
- string encryption
- constant encryption
- control-flow flattening
- opaque predicates
- junk code
- reflection-heavy design
- custom class loading
- packing
- VM-based obfuscation

### Version

- application version
- runtime version
- framework version
- Minecraft version
- mapping version
- compiler/toolchain indicators

---

# 4. Fingerprint Schema

Nên chuẩn hóa thành schema:

```json
{
  "artifact": {
    "path": "...",
    "sha256": "...",
    "size": 0,
    "format": "jar"
  },
  "platform": "jvm",
  "architecture": null,
  "runtime": {
    "name": "java",
    "version": "21"
  },
  "languages": [
    "java",
    "kotlin"
  ],
  "frameworks": [
    "fabric"
  ],
  "versions": {
    "application": "...",
    "framework": "...",
    "mapping": "..."
  },
  "obfuscation": {
    "detected": true,
    "families": [
      "name-obfuscation",
      "string-encryption"
    ]
  },
  "confidence": 0.94
}
```

---

# 5. Phase 2 — Analysis Planner

## 5.1. Không route trực tiếp

Không nên:

```text
JAR → jvm-reverse
```

Mà:

```text
JAR
 ↓
Fingerprint
 ↓
Planner
 ↓
JVM reverse
 + Deobfuscation
 + Dependency analysis
 + Bytecode analysis
 + Dynamic analysis nếu cần
```

## 5.2. Planner phải hiểu dependency

Ví dụ:

```text
Deobfuscation
requires:
  fingerprint
  bytecode-analysis
```

và:

```text
Dynamic validation
requires:
  static hypothesis
```

Planner phải tạo DAG:

```text
Fingerprint
     ↓
Bytecode
     ↓
Obfuscation detection
     ↓
Deobfuscation
     ↓
Static hypothesis
     ↓
Dynamic validation
     ↓
Cross-validation
```

## 5.3. Planner không được chạy mọi thứ

Mỗi step phải có:

```text
reason
cost
expected_value
prerequisites
risk
```

Chỉ chạy step khi expected value đủ cao.

---

# 6. Phase 3 — JVM / JAR Reverse Engine

Đây là một trong những module quan trọng nhất.

Tạo:

```text
skills/jvm-reverse/
```

## 6.1. Input

- `.jar`
- `.class`
- `.war`
- `.ear`
- nested JAR
- shaded JAR
- Java application ZIP

## 6.2. Languages

- Java
- Kotlin
- Scala
- Groovy

## 6.3. Pipeline

```text
JAR
 │
 ├── Manifest
 ├── Class inventory
 ├── Package tree
 ├── Resource inventory
 ├── Dependency inventory
 │
 ▼
Decompiler selection
 │
 ├── CFR
 ├── Vineflower/FernFlower
 └── Procyon
 │
 ▼
Bytecode analysis
 │
 ├── constant pool
 ├── methods
 ├── fields
 ├── annotations
 ├── bootstrap methods
 ├── invokedynamic
 ├── method handles
 └── synthetic/bridge methods
 │
 ▼
Obfuscation analysis
 │
 ▼
Data-flow / Call graph
 │
 ▼
Runtime correlation
```

---

# 7. JVM Bytecode Intelligence

Phải có adapter cho bytecode analysis.

Theo dõi:

- class hierarchy
- inheritance
- interfaces
- method signatures
- field usage
- exceptions
- annotations
- bootstrap methods
- `invokedynamic`
- lambda/metafactory
- method handles
- synthetic methods
- bridge methods

## 7.1. Reflection

Detect và correlate:

```text
Class.forName
Method.invoke
Constructor.newInstance
Field.get
Field.set
MethodHandle
```

Không chỉ flag; phải cố gắng tạo:

```text
Reflection Site
 ↓
Possible Target
 ↓
Confidence
 ↓
Evidence
```

## 7.2. ClassLoader

Detect:

- custom ClassLoader
- `defineClass`
- encrypted class bytes
- runtime class generation
- resource-based loading
- child-first loading
- URL-based loading

---

# 8. Phase 4 — Deobfuscation Engine

Tạo:

```text
skills/deobfuscation/
```

## 8.1. Không hard-code từng obfuscator

Nên dùng architecture:

```text
ObfuscationDetector
ObfuscationClassifier
DeobfuscationPass
Validator
```

## 8.2. Pipeline

```text
Artifact
 ↓
Detect
 ↓
Classify
 ↓
Select pass
 ↓
Create snapshot
 ↓
Transform copy
 ↓
Validate
 ↓
Compare
 ↓
Accept / Reject
```

## 8.3. Pass types

### Name

- meaningless class names
- meaningless method names
- package flattening

### String

- encoded strings
- runtime decryptors
- lookup tables
- byte-array reconstruction
- invokedynamic bootstrap string decryptors

### Constant

- arithmetic encoding
- encrypted constants
- runtime reconstruction

### Control Flow

- control-flow flattening
- opaque predicates
- dispatcher loops
- junk branches

### Reflection

- reflective method lookup
- reflective class loading
- dynamic invocation

### VM-based

- opcode interpreter
- custom bytecode
- virtualized methods

---

# 9. Deobfuscation Safety

Original artifact phải immutable.

```text
input/
  original.jar

deobfuscation/
  pass-001/
  pass-002/
  pass-003/

snapshots/
  original/
  before-pass/
  after-pass/
```

Mỗi pass phải lưu:

```text
input hash
output hash
tool version
pass version
parameters
timestamp
validation result
```

---

# 10. Phase 5 — Static Analysis

## 10.1. Call Graph

```text
Entry
 ├── A
 │    └── C
 └── B
      └── D
```

## 10.2. Data Flow

Theo dõi:

```text
Input
 ↓
Transform
 ↓
Decrypt
 ↓
Parser
 ↓
Sink
```

## 10.3. Các entity cần track

- function
- class
- method
- basic block
- string
- constant
- file
- network endpoint
- crypto operation
- process operation
- serialization
- authentication logic

---

# 11. Phase 6 — Dynamic Analysis

Dynamic analysis phải được kích hoạt dựa trên hypothesis.

## 11.1. Quy trình

```text
Static hypothesis
      ↓
Need runtime evidence?
      ↓
      YES
      ↓
Runtime tracing
      ↓
Correlate
      ↓
Confirm / Reject
```

## 11.2. Generic event schema

```json
{
  "timestamp": "...",
  "process": "...",
  "thread": "...",
  "module": "...",
  "event": "function_call",
  "symbol": "...",
  "arguments": [],
  "return_value": "...",
  "stack": [],
  "source": "runtime"
}
```

## 11.3. JVM runtime

Có thể orchestration cho:

- Java agent
- JVMTI/JFR khi phù hợp
- bytecode instrumentation
- method tracing
- class-loading tracing

## 11.4. Native runtime

Abstract các capability:

- debugger
- function tracing
- module loading
- syscall observation
- memory-region metadata

---

# 12. Phase 7 — Cross-Validation

Đây là phần phải được coi là core reliability layer.

## 12.1. Không tin một decompiler

Ví dụ:

```text
IDA
Ghidra
r2
Decompiler JVM
Bytecode
Runtime
```

phải được xem là các nguồn evidence khác nhau.

## 12.2. Normalize

Các tool có output khác nhau:

```text
IDA pseudocode
Ghidra pseudocode
r2 output
bytecode
```

phải được normalize thành representation chung.

## 12.3. So sánh

- function boundaries
- call targets
- CFG
- constants
- strings
- exception paths
- variable relationships
- type guesses

## 12.4. Consensus

```text
Tool A  ─┐
Tool B  ─┼──> Consensus
Tool C  ─┤
Runtime ─┘
```

Nếu mâu thuẫn:

```text
Status = UNCERTAIN
```

Không ép AI chọn một kết luận chỉ để có câu trả lời.

---

# 13. Phase 8 — Evidence Graph

## 13.1. Mục tiêu

Mọi finding phải truy ngược được.

```text
Finding
 ↓
Method
 ↓
Call
 ↓
String
 ↓
Bytecode
 ↓
Runtime evidence
```

## 13.2. Node

```text
Artifact
Module
Class
Method
Function
BasicBlock
String
Constant
Instruction
RuntimeEvent
NetworkEvent
Finding
Hypothesis
ToolResult
```

## 13.3. Edge

```text
CALLS
REFERENCES
CONTAINS
LOADS
DECRYPTS
RETURNS
READS
WRITES
TRIGGERS
CONFIRMS
CONTRADICTS
DERIVED_FROM
```

---

# 14. Confidence Engine

Không dùng confidence kiểu:

```text
LLM: 95%
```

mà confidence phải được xây từ evidence.

Ví dụ:

```text
Static evidence       +0.30
Bytecode confirmation  +0.25
Tool agreement         +0.20
Runtime confirmation   +0.20
Contradiction          -0.40
```

Output:

```text
Finding
Confidence: 0.91

Evidence:
  E1
  E2
  E3
```

Confidence chỉ là mức độ tin cậy, không phải proof.

---

# 15. Phase 9 — Minecraft Specialization

Minecraft phải nằm trên JVM engine.

```text
JVM Engine
    │
    └── Minecraft
          ├── Fabric
          ├── Forge
          ├── NeoForge
          ├── Quilt
          ├── Mixin
          └── Mapping
```

## 15.1. Detect

- loader
- Minecraft version
- mapping
- mod metadata
- dependencies

## 15.2. Mixin analysis

Detect:

- `@Mixin`
- `@Inject`
- `@Redirect`
- `@ModifyArg`
- `@ModifyVariable`
- `@ModifyConstant`
- `@Overwrite`
- accessor
- invoker
- injection point
- target method

Graph:

```text
Mixin
 ↓
Target Class
 ↓
Target Method
 ↓
Injection Point
```

## 15.3. Mapping abstraction

Không hard-code mapping vào skill.

```text
Obfuscated
    ↓
Mapping Provider
    ├── Yarn
    ├── Mojmap
    └── Intermediary
```

## 15.4. Version migration

```text
Old version
 ↓
Mapping
 ↓
API surface
 ↓
Class/method diff
 ↓
Mixin diff
 ↓
New version
```

Phân loại:

- unchanged
- renamed
- moved
- signature changed
- removed
- added
- behavior changed
- uncertain

---

# 16. Phase 10 — Binary / Version Diff

Nâng `binary-diff` thành một hệ thống generic.

## 16.1. So sánh

- functions
- symbols
- CFG
- strings
- constants
- imports
- exports
- class structures
- method signatures

## 16.2. Migration

```text
Old analysis
      ↓
Similarity matching
      ↓
New binary
      ↓
Migrated analysis
      ↓
Validation
```

Không tự động coi function giống tên là cùng logic.

---

# 17. Phase 11 — Tool Registry

Mỗi tool phải khai báo:

```yaml
name:
version:
platforms:
inputs:
outputs:
capabilities:
cost:
requires:
available:
```

Ví dụ:

```yaml
name: ghidra
capabilities:
  - native-static-analysis
  - decompilation
inputs:
  - pe
  - elf
  - macho
```

Planner sẽ chọn tool dựa trên:

```text
capability
target compatibility
version compatibility
availability
cost
expected evidence quality
```

---

# 18. Phase 12 — Workspace + Provenance

Case structure:

```text
case/
├── input/
├── fingerprint/
├── static/
├── dynamic/
├── deobfuscation/
├── diff/
├── evidence/
├── snapshots/
├── reports/
└── metadata/
```

Mọi artifact sinh ra phải có:

```json
{
  "artifact": "...",
  "parent": "...",
  "sha256": "...",
  "created_by": "...",
  "tool_version": "...",
  "parameters": {},
  "timestamp": "..."
}
```

---

# 19. Phase 13 — Knowledge Base

Knowledge Base phải được xây **sau evidence/validation**.

## 19.1. Không làm

```text
Target A
 ↓
LLM guess
 ↓
Save guess
 ↓
Target B
 ↓
Trust guess
```

## 19.2. Nên làm

```text
Target A
 ↓
Fingerprint
 ↓
Analysis
 ↓
Evidence
 ↓
Validation
 ↓
Successful workflow
 ↓
Save workflow
```

Target mới:

```text
Fingerprint
 ↓
Find similar cases
 ↓
Reuse workflow
 ↓
Revalidate
```

## 19.3. Case schema

```json
{
  "case_id": "...",
  "fingerprint": {},
  "workflow": [],
  "successful_steps": [],
  "failed_steps": [],
  "evidence": [],
  "lessons": []
}
```

---

# 20. Phase 14 — Regression / Benchmark

Mỗi feature mới phải có test.

## 20.1. Routing

```text
input → expected route
```

## 20.2. Fingerprinting

```text
artifact → expected fingerprint
```

## 20.3. JVM

Test:

- clean JAR
- ProGuard
- R8
- string encryption
- reflection
- invokedynamic
- custom ClassLoader
- Kotlin
- nested JAR

## 20.4. Minecraft

Test:

- Fabric
- Forge
- NeoForge
- Mixin-heavy mod
- obfuscated mod
- multiple versions
- mapping migration

## 20.5. Cross-validation

Test:

```text
tool A + tool B
      ↓
expected consensus
```

---

# 21. Phase 15 — Skill Architecture

Mỗi skill nên có manifest:

```yaml
id:
name:
version:
description:
inputs:
outputs:
capabilities:
prerequisites:
tools:
platforms:
risk_level:
tests:
```

Skill không nên tự định nghĩa routing riêng.

Routing phải có một source of truth.

---

# 22. Phase 16 — Skill Auto-Discovery

Router có thể scan:

```text
skills/*/SKILL.md
```

và build registry.

Mục tiêu:

```text
Add skill
 ↓
Manifest
 ↓
Auto-discover
 ↓
Validate
 ↓
Register
```

Giảm việc phải sửa nhiều file chỉ để thêm một skill.

---

# 23. Phase 17 — Skill Auto-Generation

Chỉ làm sau khi hệ thống ổn định.

Pipeline:

```text
Unsupported pattern
       ↓
Collect examples
       ↓
Generate draft skill
       ↓
Sandbox test
       ↓
Regression test
       ↓
Human review
       ↓
Register
```

Không được tự động đưa skill chưa test vào production.

---

# 24. Phase 18 — Reporting

## 24.1. Executive

Tóm tắt:

- target
- loại artifact
- kết quả chính
- confidence

## 24.2. Technical

Bao gồm:

- fingerprint
- tools
- methodology
- findings
- evidence
- confidence
- limitations

## 24.3. RE report

Bao gồm:

- classes/functions
- call graph
- strings
- data flow
- protocols
- runtime events
- deobfuscation passes

## 24.4. Migration report

```text
OLD
 ↓
matched
 ↓
changed
 ↓
NEW
```

---

# 25. Human-in-the-Loop

Agent phải dừng khi:

- target scope không rõ
- authorization không rõ
- cần hành động ngoài phân tích
- cần network access không rõ
- cần chạy artifact chưa rõ nguồn
- cần destructive modification
- confidence thấp nhưng impact cao

Mục tiêu:

```text
Automation
+
Control
```

không phải uncontrolled execution.

---

# 26. Những thứ KHÔNG nên ưu tiên

Không nên dành effort lớn cho việc tiếp tục mở rộng:

- AD
- Wi-Fi
- Email
- Database
- Cloud
- generic pentest

nếu mục tiêu chính là biến repo thành **RE/deobfuscation workbench**.

Những skill đó có thể giữ nguyên và bảo trì.

---

# 27. Không nên rewrite core

Giữ:

- routing system
- routing rules
- existing skill registry
- existing regression cases
- existing case workflow
- tool index

Chỉ thay đổi core khi có measurable problem.

Nguyên tắc:

```text
Existing Core
     ↓
Adapters
     ↓
New Engines
```

thay vì:

```text
Delete Core
     ↓
Rewrite Everything
```

---

# 28. Repository Structure đề xuất

```text
reverse-skill/
│
├── core/
│   ├── router/
│   ├── planner/
│   ├── fingerprint/
│   ├── workspace/
│   ├── provenance/
│   ├── evidence/
│   └── confidence/
│
├── skills/
│   ├── jvm-reverse/
│   ├── minecraft-reverse/
│   ├── deobfuscation/
│   ├── dynamic-analysis/
│   ├── cross-validation/
│   ├── target-fingerprint/
│   ├── binary-diff/
│   └── ...
│
├── tools/
│   ├── registry/
│   ├── adapters/
│   └── capability-detection/
│
├── schemas/
│   ├── artifact.schema.json
│   ├── fingerprint.schema.json
│   ├── evidence.schema.json
│   ├── case.schema.json
│   └── skill.schema.json
│
├── tests/
│   ├── routing/
│   ├── fingerprint/
│   ├── jvm/
│   ├── minecraft/
│   ├── deobfuscation/
│   ├── validation/
│   └── dynamic/
│
└── docs/
    ├── architecture/
    ├── skills/
    ├── workflows/
    └── benchmarks/
```

---

# 29. Implementation Order

## Phase A — Foundation

- [ ] Target fingerprint
- [ ] Tool registry
- [ ] Planner
- [ ] Workspace
- [ ] Provenance
- [ ] Schema versioning

## Phase B — JVM

- [ ] JAR inventory
- [ ] Bytecode analysis
- [ ] Decompiler adapters
- [ ] Reflection analysis
- [ ] ClassLoader analysis
- [ ] String analysis
- [ ] JVM regression suite

## Phase C — Deobfuscation

- [ ] Detector
- [ ] Classifier
- [ ] Pass engine
- [ ] Snapshot
- [ ] Rollback
- [ ] Validation

## Phase D — Reliability

- [ ] Cross-tool normalization
- [ ] CFG comparison
- [ ] Function matching
- [ ] Consensus
- [ ] Confidence engine

## Phase E — Minecraft

- [ ] Loader detection
- [ ] Version detection
- [ ] Mapping abstraction
- [ ] Mixin analysis
- [ ] Dependency graph
- [ ] Version migration

## Phase F — Dynamic

- [ ] Event schema
- [ ] JVM tracing
- [ ] Native tracing
- [ ] Network correlation
- [ ] Static/dynamic evidence linking

## Phase G — Knowledge

- [ ] Case database
- [ ] Similarity search
- [ ] Workflow reuse
- [ ] Lessons learned

## Phase H — Self Evolution

- [ ] Skill discovery
- [ ] Skill generation
- [ ] Sandbox
- [ ] Regression promotion
- [ ] Rollback

---

# 30. Metrics

Không đánh giá bằng số lượng skill.

## Routing accuracy

```text
correct_routes / total_cases
```

## Fingerprint accuracy

```text
correct_fields / expected_fields
```

## Evidence coverage

```text
findings_with_evidence / total_findings
```

## Cross-tool agreement

```text
consensus / compared_items
```

## Reproducibility

```text
reproducible_cases / total_cases
```

## Regression rate

```text
new_failures / total_regression_cases
```

## Efficiency

Theo dõi:

- runtime
- memory
- tool calls
- redundant analyses
- artifact count

---

# 31. Definition of Done

Bản nâng cấp được coi là đạt khi agent có thể nhận:

```text
"Phân tích target X"
```

và tự thực hiện:

```text
1. Fingerprint
2. Xác định runtime/platform
3. Detect obfuscation
4. Chọn workflow
5. Kiểm tra tool availability
6. Chạy static analysis
7. Tạo hypotheses
8. Chạy deobfuscation khi cần
9. Chạy dynamic validation khi cần
10. Cross-check
11. Build evidence graph
12. Calculate confidence
13. Preserve provenance
14. Generate report
15. Store validated workflow
```

Target tương tự trong tương lai:

```text
Target
 ↓
Similar cases
 ↓
Proven workflow
 ↓
Revalidate
 ↓
Improved workflow
```

---

# 32. Final Design Philosophy

Hệ thống không nên hướng tới:

```text
"AI biết nhiều tool"
```

mà hướng tới:

```text
"AI biết khi nào dùng tool nào,
biết tại sao dùng nó,
biết kết quả có đáng tin không,
và biết cách kiểm chứng kết quả."
```

## Xương sống cuối cùng

```text
Fingerprint
    ↓
Plan
    ↓
Analyze
    ↓
Deobfuscate
    ↓
Validate
    ↓
Correlate
    ↓
Evidence
    ↓
Confidence
    ↓
Report
    ↓
Learn
```

Đây là thứ tự ưu tiên chính xác hơn việc chỉ tiếp tục thêm skill mới.

---

# 33. Recommended First Release

Nếu phải chọn một release đầu tiên có tác động lớn nhất:

```text
R1
 ├── Target Fingerprint
 ├── Analysis Planner
 ├── JVM Reverse
 ├── Bytecode Analysis
 ├── Deobfuscation Engine v1
 ├── Evidence Graph v1
 ├── Cross-Validation v1
 └── Regression Suite
```

Sau đó:

```text
R2
 ├── Minecraft specialization
 ├── Dynamic Analysis
 ├── Version/Binary Diff
 └── Runtime correlation
```

Cuối cùng:

```text
R3
 ├── Knowledge Base
 ├── Workflow reuse
 ├── Skill discovery
 └── Controlled skill generation
```

**Không nên nhảy thẳng tới R3.**

Nếu fingerprint/evidence/validation chưa đủ tốt thì self-learning sẽ chỉ làm hệ thống học và tái sử dụng những kết luận sai.

---

# 34. Kết luận

Ưu tiên thật sự của `reverse-skill` nên là:

```text
                 ┌──────────────────┐
                 │ Target Fingerprint│
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Analysis Planner │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ JVM / Native RE  │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Deobfuscation    │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Dynamic Analysis │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Cross Validation │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Evidence Graph   │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Confidence       │
                 └────────┬─────────┘
                          ↓
                 ┌──────────────────┐
                 │ Knowledge Base   │
                 └──────────────────┘
```

**JVM/JAR + Deobfuscation + Fingerprinting + Evidence/Validation là xương sống.**

Minecraft, mobile, native, firmware, browser... nên được xây như các specialization sử dụng chung xương sống đó.
