# Comprehensive Upgrade Specification — Exploit & Pentesting + Specialized Domains

## Mục tiêu

Nâng cấp toàn diện hai nhóm **Exploit & Pentesting** và **Specialized Domains** của `reverse-skill` từ một hệ thống gồm nhiều security skill, tool wrapper và workflow riêng lẻ thành một **Security Assessment Platform có khả năng reasoning, correlation, validation và cross-domain analysis**.

Không ưu tiên việc tăng số lượng tool hoặc bổ sung hàng loạt kỹ thuật khai thác riêng lẻ. Mục tiêu chính là tận dụng toàn bộ capability hiện có, chuẩn hóa cách chúng giao tiếp với nhau và xây thêm các lớp còn thiếu để hệ thống có thể hiểu một target như một hệ thống bảo mật hoàn chỉnh thay vì xử lý từng tool hoặc từng domain một cách độc lập.

Kiến trúc sau nâng cấp phải hướng tới pipeline:

```text
Scope
  ↓
Authorization
  ↓
Target Understanding
  ↓
Asset Discovery
  ↓
Attack Surface Modeling
  ↓
Risk / Priority
  ↓
Test Planning
  ↓
Vulnerability Hypothesis
  ↓
Validation
  ↓
Evidence
  ↓
Finding
  ↓
Impact
  ↓
Attack Path
  ↓
Remediation
  ↓
Retest
  ↓
Knowledge / Regression
```

Mọi active testing và exploit validation phải được thực hiện trong phạm vi được phép, có scope enforcement, rate limiting, execution state và safety gate phù hợp. Không được thiết kế hệ thống theo hướng mặc định cho rằng mọi target hoặc mọi action đều được phép.

---

# 1. Chuyển Exploit & Pentesting từ Tool-Centric sang Assessment-Centric

`pentest-tools`, `attack-chain`, `api-security`, `pwn-chain`, `patch-diff-exploit` và các security skill hiện có phải được coi là **capability providers**, không phải trung tâm điều phối.

Cần xây một lớp assessment core phía trên chúng.

Thay vì:

```text
Request
 ↓
Tool
 ↓
Output
```

phải chuyển thành:

```text
Request
 ↓
Assessment Context
 ↓
Target Model
 ↓
Attack Surface
 ↓
Planner
 ↓
Capability Selection
 ↓
Test
 ↓
Observation
 ↓
Hypothesis
 ↓
Validation
 ↓
Evidence
 ↓
Finding
```

Điều này cho phép hệ thống quyết định tại sao một tool cần được chạy, kết quả của nó có ý nghĩa gì và bước tiếp theo nên là gì.

---

# 2. Xây Unified Security Assessment Model

Tất cả pentest và specialized domain phải sử dụng một security model chung.

Model tối thiểu phải có:

```text
Case
Scope
Target
Asset
Identity
Role
Resource
Service
Endpoint
Configuration
Observation
Hypothesis
Test
Evidence
Finding
Impact
Attack Path
Remediation
Retest
```

Các module khác nhau có thể mở rộng model nhưng không được tạo schema hoàn toàn riêng biệt khiến dữ liệu không thể liên kết.

Ví dụ:

```text
Mobile Asset
    ↓
API Endpoint
    ↓
Identity
    ↓
Cloud Resource
    ↓
Sensitive Data
```

phải có thể biểu diễn trong cùng một assessment graph.

---

# 3. Nâng cấp Scope và Authorization thành Security Control Plane

Scope không nên chỉ là một file cấu hình.

Nó phải trở thành một control plane quyết định một action có được thực hiện hay không.

Mỗi operation cần được đánh giá theo:

```text
Target
Scope
Authorization
Action Type
Risk
Time Window
Rate Limit
Environment
```

Kết quả:

```text
ALLOW
DENY
REQUIRE_APPROVAL
```

Scope phải hỗ trợ:

* include targets
* exclude targets
* network boundaries
* domain boundaries
* port/service restrictions
* environment restrictions
* active/passive restrictions
* destructive-action restrictions
* rate/concurrency limits
* expiration

Các skill phía dưới không được tự ý bypass control plane.

---

# 4. Xây Target Model và Asset Discovery Layer

Trước khi pentest, hệ thống phải hiểu target.

Không chỉ xác định:

```text
IP
Port
Service
```

mà phải xây:

```text
Target
 ├── Domains
 ├── Hosts
 ├── Services
 ├── Applications
 ├── APIs
 ├── Identities
 ├── Cloud Resources
 ├── Containers
 ├── Mobile Clients
 ├── Firmware
 └── Dependencies
```

Mỗi asset cần có:

```text
asset_id
type
source
confidence
scope
relationships
observed_at
last_verified
```

Mọi asset discovery phải giữ provenance để biết nó được phát hiện từ đâu.

---

# 5. Xây Attack Surface Graph

Đây phải trở thành một thành phần trung tâm.

Graph cần biểu diễn:

```text
Asset
 ↓
Exposure
 ↓
Service
 ↓
Application
 ↓
Endpoint
 ↓
Identity
 ↓
Resource
 ↓
Data
```

Các relationship cần có provenance và confidence.

Ví dụ:

```text
Mobile App
    └── CALLS → API
                    └── AUTHENTICATES → Identity
                                           └── HAS_ACCESS → Cloud Resource
                                                               └── CONTAINS → Data
```

Graph này phải được sử dụng bởi planner, finding correlation và attack-path analysis.

---

# 6. Xây Vulnerability Hypothesis Engine

Scanner output không được tự động trở thành vulnerability.

Mỗi signal phải đi qua:

```text
Observation
 ↓
Hypothesis
 ↓
Test Plan
 ↓
Validation
 ↓
Decision
```

Một hypothesis phải mô tả:

```text
What is suspected?
Why is it suspected?
Which asset is affected?
What evidence supports it?
What validation is needed?
What would disprove it?
```

Kết quả:

```text
CONFIRMED
REJECTED
INCONCLUSIVE
DUPLICATE
```

Mục tiêu chính là giảm false positive và tăng confidence.

---

# 7. Xây Finding Lifecycle thống nhất

Mọi security finding phải sử dụng cùng lifecycle:

```text
CANDIDATE
   ↓
VALIDATING
   ↓
CONFIRMED / REJECTED / INCONCLUSIVE
   ↓
DEDUPLICATED
   ↓
PRIORITIZED
   ↓
REPORTED
   ↓
REMEDIATION
   ↓
RETEST
   ↓
RESOLVED / REGRESSION
```

Không để mỗi skill tự định nghĩa một lifecycle khác nhau.

---

# 8. Xây Evidence Graph

Evidence phải là thành phần first-class.

Mỗi finding phải có thể truy ngược:

```text
Finding
 ↓
Evidence
 ↓
Observation
 ↓
Test
 ↓
Tool / Skill
 ↓
Target
 ↓
Scope
```

Evidence cần chứa:

```text
id
type
source
timestamp
target
case
hash/provenance
test conditions
confidence
```

Một finding có thể có nhiều evidence từ nhiều skill khác nhau.

---

# 9. Xây Finding Correlation và Deduplication

Nếu:

```text
Tool A
Tool B
Manual Validation
Source Review
Runtime Observation
```

đều phát hiện cùng một vấn đề thì phải tạo:

```text
Finding F-001
```

với:

```text
Evidence A
Evidence B
Evidence C
Evidence D
```

không tạo bốn findings riêng biệt.

Correlation phải dựa trên:

```text
Asset
Affected component
Vulnerability class
Location
Behavior
Evidence
```

---

# 10. Nâng cấp Risk Engine

Không lấy severity của scanner làm kết luận cuối cùng.

Risk phải được đánh giá từ:

```text
Severity
Confidence
Exposure
Exploitability
Required Privilege
User Interaction
Asset Criticality
Business Impact
Attack-Path Position
Mitigations
```

Tách rõ:

```text
Severity
Confidence
Exploitability
Business Impact
```

để tránh trường hợp một finding có severity cao nhưng evidence yếu bị coi như vulnerability đã được chứng minh.

---

# 11. Xây Test Planner

Pentest planner phải lựa chọn test dựa trên:

```text
Risk
Information Gain
Cost
Exposure
Confidence
Dependencies
Safety
```

Planner phải tránh chạy lại các test không cần thiết.

Ví dụ:

```text
Discovery
 ↓
Fingerprint
 ↓
High-value surface
 ↓
Targeted validation
```

thay vì:

```text
Run every scanner
Run every scanner again
Run every scanner again
```

Planner cũng phải biết domain nào cần được kích hoạt.

---

# 12. Nâng cấp Authentication và Authorization thành Core Capability

Authentication/Authorization không nên chỉ nằm trong API security.

Xây một identity abstraction:

```text
Identity
 ↓
Role
 ↓
Permission
 ↓
Resource
 ↓
Action
 ↓
Trust Boundary
```

Abstraction này phải được sử dụng bởi:

```text
Web
API
Mobile
Cloud
Identity
Container
Enterprise
```

Điều này giúp phát hiện các vấn đề nằm ở ranh giới giữa các domain.

---

# 13. Bổ sung Business Logic Assessment Layer

Automated security testing thường mạnh ở technical vulnerabilities nhưng yếu ở business logic.

Cần model:

```text
Entity
State
Action
Actor
Permission
Transition
```

Ví dụ:

```text
State A
 ↓
Action
 ↓
State B
```

Planner phải hiểu:

```text
valid transition
invalid transition
missing authorization
unexpected state
replay
workflow inconsistency
```

Mục tiêu không phải bổ sung payload mà là giúp agent **hiểu application state**.

---

# 14. Nâng cấp Attack Chain thành Evidence-Based Attack Path

`attack-chain` cần chuyển từ workflow đơn thuần thành graph reasoning.

Mỗi edge phải có:

```text
source
destination
relationship
evidence
confidence
assumption
```

Phải phân biệt:

```text
POSSIBLE
INFERRED
SUPPORTED
VALIDATED
```

Không được biến một chain suy luận thành một chain đã được chứng minh.

---

# 15. Xây Cross-Domain Correlation

Đây là phần quan trọng nhất của Specialized Domains.

Ví dụ:

```text
Mobile
 ↓
API
 ↓
Identity
 ↓
Cloud
 ↓
Data
```

hoặc:

```text
Firmware
 ↓
Network
 ↓
Backend
 ↓
Cloud
```

Các domain phải có thể chia sẻ:

```text
Asset
Identity
Resource
Finding
Evidence
Trust Boundary
Attack Path
```

Không để:

```text
mobile skill
api skill
cloud skill
```

hoạt động như ba hệ thống hoàn toàn độc lập.

---

# 16. Nâng cấp Specialized Domains thành Domain-Aware Engines

Các domain hiện có cần được chuẩn hóa thành:

```text
Domain Model
 ↓
Discovery
 ↓
Assessment
 ↓
Validation
 ↓
Evidence
 ↓
Finding
```

Mỗi domain được phép có logic riêng nhưng phải output theo common security schema.

Các domain cần được đánh giá và hoàn thiện gồm:

```text
Web
API
Mobile
Firmware / IoT
Cloud
Identity / Enterprise
Container / Kubernetes
LLM / AI
Supply Chain
Network
Browser
Hardware / Protocol
OT / ICS
Automotive
```

Không nhất thiết phải triển khai tất cả ngay lập tức. Cần ưu tiên theo dependency và giá trị thực tế.

---

# 17. Cloud Security Domain

Cloud cần trở thành một domain chính thức thay vì chỉ được xử lý gián tiếp qua các tool.

Domain model:

```text
Account
 ↓
Identity
 ↓
Role
 ↓
Policy
 ↓
Resource
 ↓
Network
 ↓
Data
```

Nó phải tích hợp trực tiếp với:

```text
Identity Security
API Security
Container Security
Supply Chain
Attack Path
```

---

# 18. Identity / Enterprise Security Domain

Tạo domain riêng cho identity và enterprise environments.

Domain phải có khả năng biểu diễn:

```text
User
Group
Role
Machine
Service Account
Trust
Permission
Resource
```

và tạo được privilege graph:

```text
Identity
 ↓
Permission
 ↓
Resource
 ↓
Higher-Privilege Boundary
```

Không chỉ thực hiện enumeration mà phải phân tích relationship.

---

# 19. Container / Kubernetes Security Domain

Tạo domain riêng:

```text
Cluster
Namespace
Pod
Container
ServiceAccount
Role
Secret
Service
Network
```

Domain này phải liên kết được với:

```text
Cloud
Identity
Supply Chain
Network
Application
```

để một finding trong Kubernetes có thể trở thành một node trong attack path lớn hơn.

---

# 20. Mobile / Firmware / IoT Integration

Không tạo lại những skill đã tồn tại.

Thay vào đó nâng integration:

```text
Mobile
 ↓
API
 ↓
Identity
 ↓
Cloud
```

và:

```text
Firmware
 ↓
Device
 ↓
Network
 ↓
Backend
 ↓
Cloud
```

Các domain này phải có khả năng đẩy asset và evidence vào Security Assessment Core.

---

# 21. AI / LLM Security Integration

`llm-security` cần được xem như một domain có attack surface riêng:

```text
Model
 ↓
Application
 ↓
Prompt
 ↓
Agent
 ↓
Tool
 ↓
Data
 ↓
External System
```

Quan trọng nhất là liên kết AI findings với application, identity, data và external services thay vì coi LLM là một hệ thống tách biệt.

---

# 22. Supply Chain Integration

Supply Chain phải liên kết:

```text
Dependency
 ↓
Build
 ↓
Artifact
 ↓
Distribution
 ↓
Deployment
 ↓
Runtime
```

Kết quả phải có thể đi vào:

```text
Attack Surface
Finding
Attack Path
Risk
```

để đánh giá impact của một supply-chain weakness trong context của hệ thống thật.

---

# 23. Environment / Lab Management

Pentest và specialized security research cần environment awareness.

Mỗi case nên biết:

```text
Environment
Architecture
OS
Runtime
Dependencies
Isolation
Credentials Context
Network Context
Cleanup State
```

Phải phân biệt rõ:

```text
Production Assessment
Staging Assessment
Dedicated Security Lab
Exploit Development Lab
```

Không để exploit-development workflow vô tình được xử lý giống production pentest workflow.

---

# 24. Capability Registry

Tool registry hiện có nên được nâng thành capability registry.

Không chỉ:

```text
tool exists
```

mà:

```yaml
tool:
version:
capabilities:
supported_platforms:
input_schema:
output_schema:
risk_level:
scope_requirements:
dependencies:
parser:
validator:
```

Planner từ đó có thể chọn tool phù hợp thay vì hard-code tool selection.

---

# 25. Coverage Engine

Hệ thống phải trả lời được:

> “Đã kiểm tra bao nhiêu phần của attack surface và còn thiếu gì?”

Coverage phải được tính theo:

```text
Assets
Services
Endpoints
Identities
Roles
Resources
Domains
Tests
Findings
Validation
```

Ví dụ:

```text
Assets:       100%
Endpoints:     82%
Auth states:   60%
Cloud:         75%
Retest:        40%
```

Điều này quan trọng hơn chỉ biết “Nmap đã chạy”.

---

# 26. Assessment Completeness

Một case không được coi là complete chỉ vì tất cả commands đã chạy.

Phải có:

```text
Scope coverage
+
Asset coverage
+
Attack-surface coverage
+
Test coverage
+
Validation coverage
+
Evidence coverage
```

Nếu còn vùng chưa kiểm tra, report phải ghi rõ.

---

# 27. Retest và Regression

Mỗi confirmed finding phải có khả năng trở thành test case.

```text
Finding
 ↓
Remediation
 ↓
Retest
 ↓
Result
 ↓
Regression Case
```

Các regression case sau đó phải được đưa vào test suite để đảm bảo capability không suy giảm trong các lần cập nhật skill.

---

# 28. Knowledge / Precedent Layer

Knowledge base không nên chỉ lưu:

```text
tool X
payload Y
```

Mà nên lưu:

```text
Target Pattern
 ↓
Observed Signal
 ↓
Hypothesis
 ↓
Validation
 ↓
Evidence
 ↓
Result
 ↓
False Positive Reason
 ↓
Recommended Next Step
```

Knowledge chỉ được promote thành precedent khi có validation đủ mạnh.

---

# 29. Security Reasoning Regression

Regression hiện tại cần được mở rộng từ routing thành assessment reasoning.

Không chỉ test:

```text
request → correct skill
```

mà test:

```text
request
 ↓
scope
 ↓
fingerprint
 ↓
planner
 ↓
test selection
 ↓
interpretation
 ↓
validation
 ↓
finding
 ↓
risk
 ↓
report
```

Mỗi stage phải có benchmark.

---

# 30. Quality Metrics

Không dùng số lượng tool làm metric chính.

Cần theo dõi:

```text
Asset Discovery Coverage
Attack Surface Coverage
Test Coverage
Validation Precision
False Positive Rate
Finding Deduplication Rate
Evidence Completeness
Risk Calibration
Attack Path Validation Rate
Retest Accuracy
Cross-Domain Correlation Accuracy
Planner Efficiency
```

Mục tiêu là tăng **chất lượng assessment**, không phải tăng số lượng command đã chạy.

---

# 31. Final Architecture

Kiến trúc sau nâng cấp nên hướng tới:

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
                            RISK ENGINE
                                  │
                                  ▼
                         ATTACK PATH GRAPH
                                  │
                                  ▼
                         REMEDIATION / RETEST
                                  │
                                  ▼
                       KNOWLEDGE / REGRESSION
```

---

# 32. Implementation Principle

Không được giải quyết vấn đề bằng cách liên tục tạo thêm skill riêng lẻ.

Mỗi capability mới phải trả lời:

```text
Nó thuộc domain nào?
Nó sử dụng common security model nào?
Nó tạo observation hay finding?
Nó có validation hay không?
Evidence được lưu ở đâu?
Nó liên kết với asset graph thế nào?
Nó có thể đóng góp vào attack path không?
Nó có thể được retest không?
Nó có regression test không?
```

Nếu một capability không thể trả lời các câu hỏi trên, không nên đưa nó vào core architecture một cách vội vàng.

---

# 33. Final Goal

Mục tiêu cuối cùng không phải:

```text
“có thêm nhiều pentest tools”
```

mà là:

```text
“agent có thể thực hiện một security assessment có cấu trúc,
có scope, hiểu target, hiểu attack surface,
chọn test hợp lý, phân biệt signal với vulnerability,
xác minh finding, liên kết evidence,
đánh giá impact, nối các finding thành attack path,
tạo remediation, retest và học từ kết quả.”
```

Exploit & Pentesting phải trở thành **assessment/reasoning layer**.

Specialized Domains phải trở thành **domain intelligence layer**.

Các tool và skill hiện có trở thành **capability layer**.

Ba lớp này phải được nối bằng:

```text
Common Security Model
+
Attack Surface Graph
+
Evidence Graph
+
Finding Lifecycle
+
Risk Model
+
Cross-Domain Correlation
+
Regression
```

Đây là hướng nâng cấp ưu tiên cao nhất cho `reverse-skill`. Không cần biến repository thành một collection khổng lồ của payload và scanner; cần biến nó thành một hệ thống có khả năng **hiểu, lập kế hoạch, kiểm chứng và liên kết các kết quả bảo mật một cách có bằng chứng và có thể tái lập**.
