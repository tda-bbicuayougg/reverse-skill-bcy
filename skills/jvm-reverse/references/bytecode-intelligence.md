# JVM Bytecode Intelligence Reference

## Core Analysis Areas

1. **Constant Pool Inspection**:
   - String constants, Class references, MethodRef, FieldRef, NameAndType.
   - Look for encrypted string patterns, base64 payloads, or URL endpoints.

2. **Reflection & Dynamic Calls**:
   - `java.lang.reflect.Method.invoke(Object obj, Object... args)`
   - `java.lang.Class.forName(String className)`
   - `java.lang.invoke.MethodHandle` & `invokedynamic` (LambdaMetafactory, string decryptor bootstraps).

3. **ClassLoader Identification**:
   - Overridden `loadClass` or `findClass`.
   - Native calls to `defineClass(String name, byte[] b, int off, int len)`.

4. **Decompiler Selection Logic**:
   - **CFR**: Excellent for modern Java (varhandles, record types, sealed classes).
   - **Vineflower**: Cleanest output for Kotlin and complex control flow.
   - **Procyon**: Strong against older obfuscators and enum/switch constructs.
