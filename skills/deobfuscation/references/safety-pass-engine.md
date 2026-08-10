# Deobfuscation Safety & Pass Engine Reference

## Immutable Artifact Rules

1. **Original Artifact Preserved**:
   - `input/original.jar` is NEVER modified.
   - All transformations are performed on working copies stored in `work/deobfuscation/pass-00X/`.

2. **Snapshot & Rollback Flow**:
   ```
   Original Input
        ↓
   Snapshot (snapshots/original/)
        ↓
   Pass 1 (String Decryption) → Validate → Pass? YES → Keep
        ↓
   Pass 2 (Control Flow Un-flattening) → Validate → Pass? NO → Rollback to Pass 1
   ```

3. **Pass Categories**:
   - **Name Pass**: Meaningless class/method renaming.
   - **String Pass**: Decrypts encoded strings or constant byte arrays.
   - **Control-Flow Pass**: Removes opaque predicates and dispatcher loops.
   - **Reflection Pass**: Converts reflection calls into direct symbol invocations when verifiable.
