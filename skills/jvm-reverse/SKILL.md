---
name: jvm-reverse
description: Analyzes Java, Kotlin, Scala, and Groovy bytecode from JAR, CLASS, WAR, EAR, and shaded archives. Orchestrates decompiler selection (CFR, Vineflower, Procyon), reflection tracing, and invokedynamic inspection.
---

# JVM / JAR Reverse Engine

Comprehensive JVM bytecode analysis skill for `reverse-skill-bcy`.

## Capabilities

- **JAR Inventory**: Extracts manifest, package structure, dependencies, and class count.
- **Bytecode Inspection**: Parses Constant Pool, `invokedynamic`, annotations, and synthetic methods.
- **Decompiler Selection**: Orchestrates available decompilers (CFR, Vineflower, Procyon, jadx) based on tool availability.
- **Reflection Tracing**: Flags `Class.forName`, `Method.invoke`, `Field.get/set`, and `MethodHandle` calls.
- **Custom ClassLoader Detection**: Identifies `defineClass`, encrypted bytecode resources, and dynamic class generation.

## Usage

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File skills/jvm-reverse/scripts/analyze-jar.ps1 -JarPath "target.jar" -OutDir "work/jvm-analysis"
```
